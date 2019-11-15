//
//  CardValidatorTests.swift
//  CardValidatorTests
//
//  Created by Станислав Шияновский on 11/14/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import XCTest
@testable import CardValidator

class CardValidatorTests: XCTestCase {

    // Create class under the test
    private var validator: Validator!
    
    // Test empty number value validating
    public func testEmptyNumberNotValid() {
        let number = ""
        validator = Validator(number)
        validator.validate { (success, reason) in
            XCTAssertEqual(success, false, "Number shouldn't be empty")
        }
    }
    
    // Test non numeric characters validating
    public func testWithoutAlphabeticalChars() {
        let number = "sometext"
        validator = Validator(number)
        validator.validate { (success, reason) in
            XCTAssertEqual(success, false, "Number shouldn't contains any characters besides the numbers")
        }
    }
    
    // Test special characters validating
    public func testWithoutSpecialChars() {
        let number = "!@#$%"
        validator = Validator(number)
        validator.validate { (success, reason) in
            XCTAssertEqual(success, false, "Number shouldn't contains any special characters")
        }
    }
    
    // Test length validation
    public func testNumberLength() {
        var number = "1"
        validator = Validator(number)
        validator.validate { (success, reason) in
            XCTAssertEqual(success, false, "Number should be great or equal 12 charaecters length")
        }
        
        number = "12345678901234567890"
        validator = Validator(number)
        validator.validate { (success, reason) in
            XCTAssertEqual(success, false, "Number should be less or equal 19 charaecters length")
        }
    }
    
    // Test zero leading
    public func testZeroLeading() {
        let number = "0123456789123456"
        validator = Validator(number)
        validator.validate { (success, reason) in
            XCTAssertEqual(success, false, "Number shouldn't starts from zero number")
        }
    }
    
    // Test success luhn validation
    public func testLuhnAlgorithmConformity() {
        let number = "4929804463622139"
        let expectation = self.expectation(description: "LuhnAlgorithm")
        var result = false
        
        validator = Validator(number)
        validator.validate { (success, reason) in
            result = success
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(result, true, "Number should pass the luhn algorithm")
    }
    
    // Test fail luhn validation
    public func testLuhnAlgorithmNotConformity() {
        let number = "333344445555"
        let expectation = self.expectation(description: "LuhnAlgorithm")
        var result = false
        
        validator = Validator(number)
        validator.validate { (success, reason) in
            result = success
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(result, false, "Number should pass the luhn algorithm")
    }
}
