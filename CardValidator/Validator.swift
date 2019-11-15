//
//  Validator.swift
//  CardValidator
//
//  Created by Станислав Шияновский on 11/15/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Foundation

public typealias ValidationResult = (Bool, String, CardValidation?)
public typealias Handler = (ValidationResult) -> ()

public class Validator {
    
    private var number: String
    
    public init(_ value: String) {
        number = value
    }
    
    public func validate(completion: @escaping Handler) {
        
        guard isNotEmpty() else {
            completion((false, Constants.ReasonDescription.emptyError, nil))
            return
        }
        
        guard withoutCharacters() else {
            completion((false, Constants.ReasonDescription.containsCharsError, nil))
            return
        }
        
        guard lengthValidation() else {
            completion((false, Constants.ReasonDescription.lengthError, nil))
            return
        }
        
        guard noZeroLeadingValidation() else {
            completion((false, Constants.ReasonDescription.zeroLeadingError, nil))
            return
        }
        
        request(completion: completion)
    }
    
    private func isNotEmpty() -> Bool {
        return !number.isEmpty
    }
    
    private func withoutCharacters() -> Bool {
        let range = NSRange(location: 0, length: number.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: NSRegularExpression.Options.caseInsensitive)
        return regex.firstMatch(in: number, options: [], range: range) == nil
    }
    
    private func lengthValidation() -> Bool {
        return (number.count >= 12 && number.count <= 19)
    }
    
    private func noZeroLeadingValidation() -> Bool {
        return !number.hasPrefix("0")
    }
    
    // MARK: Network logic -
    
    private func request(completion: @escaping Handler) {
        let request = URLRequest(url: prepareUrl())
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping Handler) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                let card = self?.decodeJSON(type: CardValidation.self, from: data)
                
                guard card?.number.luhn == true else {
                    completion((false, Constants.ReasonDescription.luhnError, card))
                    return
                }
                
                completion((true, Constants.ReasonDescription.cardValid, card))
            }
        })
    }
    
    private func prepareUrl() -> URL {
        var components = URLComponents()
        components.scheme = Constants.API.scheme
        components.host = Constants.API.host
        return components.url!.appendingPathComponent("/\(number)")
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard
            let data = from,
            let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
