//
//  CardValidationModel.swift
//  CardValidator
//
//  Created by Станислав Шияновский on 11/15/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Foundation

// MARK: - CardValidation
struct CardValidation: Decodable {
    let number: Number
    let scheme: String
}

// MARK: - Number
struct Number: Decodable {
    let length: Int
    let luhn: Bool
}
