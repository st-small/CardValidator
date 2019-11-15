//
//  CardValidationModel.swift
//  CardValidator
//
//  Created by Станислав Шияновский on 11/15/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Foundation

// MARK: - CardValidation
public struct CardValidation: Decodable {
    public let number: Number
    public let scheme: String
}

// MARK: - Number
public struct Number: Decodable {
    public let length: Int
    public let luhn: Bool
}
