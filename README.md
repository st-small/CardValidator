# CardValidator Framework
This is the first part of terms of reference. Full description referenece is: [Description](https://github.com/st-small/CardValidator/blob/master/SDK%20(iOS)_test_assignment.pdf)

## Short desciption
CardValidator allows to validate numbers of payments cards using three parts of validation:
1. Card length should be 12-19 digits
2. Card's number shouldn't start from zero
3. Card's number should pass Luhn algortihm

To validate payment card's number just create Validator object with number value, where value is string property.

```swift
let validator = Validator("4929804463622138")

```

To check card number, validate it and get the validation result in completion block:

```swift
validator.validate { (success, reason, card) in
    // success, reason
}
```
Validator result contains boolean result 'success' and string value of 'reason'. It very easy shows all cases of validation stages and helps to know what validation process card's number has failed. Also it contains optional 'card' value that helps if card was validated successfully and could to show it's scheme (Visa, Mastercard, AmericanExpress etc).

Framework written using Swift language and can be use in iOS, MacOS and tvOS applications. It has unit tests with 100% coverage.


