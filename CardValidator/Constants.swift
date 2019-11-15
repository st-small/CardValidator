//
//  Constants.swift
//  CardValidator
//
//  Created by Станислав Шияновский on 11/15/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Foundation

public struct Constants {
    
    public struct ReasonDescription {
        static let emptyError = "The card number can't be blank"
        static let containsCharsError = "There can't be any letters or special characters in the card number, just only numbers"
        static let lengthError = "The card number must consist of a minimum of 12 digits and a maximum of 19 digits"
        static let zeroLeadingError = "The card number cannot start with 0, enter the correct value"
        static let luhnError = "Your card doesn't pass the Luhn algorithm test"
        static let cardValid = "Your card number is valid!"
    }
    
    public struct API {
        static let scheme = "https"
        static let host = "lookup.binlist.net"
    }
}
