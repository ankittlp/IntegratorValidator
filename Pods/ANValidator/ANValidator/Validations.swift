//
//  Validations.swift
//  Milq
//
//  Created by Ankit on 02/04/20.
//  Copyright © 2020 Milq Inc. All rights reserved.
//

import Foundation


@propertyWrapper
public struct Validate<T> {
    
    private var validatedValue : T?
    var validationStatus : (status: Bool, statusMessage: String) = (false,"Undefined")
    private var validationRule : ValidationRule<T>
    
    public var wrappedValue : T? {
        
        get {
            
            return validatedValue
        }
        set {
            
            validatedValue = newValue
            
            if let val = validatedValue {
                
                validationStatus = validationRule.rule(val)
                
            }else {
                
                validationStatus = (false,"Value can not be nil")
            }
            
        }
    }
    
    public init(validation: ValidationRule<T>) {
        self.validationRule = validation
    }
    
    public var projectedValue : (status: Bool, statusMessage: String) {
         return validatedValue == nil ? (false,"Value can not be nil") : validationStatus
    }
}

public struct ValidationRule<T> {
    
    public typealias Validation = (T) -> (status: Bool, statusMessage: String)
    
    
    let rule : Validation
    
    public init(_ rule: @escaping Validation) {
        self.rule = rule
    }
    
}

public extension ValidationRule where T == String {
    
    
    static func regex(_ pattern: String, failedMessage :  String = "Failed") -> Self {
        
        return .init { value in
            let predicate = NSPredicate(format: "SELF MATCHES %@", (pattern))
            
            let result = predicate.evaluate(with: value)
            
            return (result,result ? "Validated" : failedMessage)
        }
    }
    
    static var email : Self  {
        
        return self.regex(".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*", failedMessage: "Email is not correct")
    }
    
    static var phoneNumber: Self {
        return self.regex("^[0-9+]{0,1}+[0-9]{5,16}$", failedMessage: "Phone number is not correct")
    }
    
    static var password : Self  {
        return .init{ value in
            print("VAlidation Value \(value)")
            return (true,"Success")
        }
    }
    
    static func username(_ pattern: String = "^@[A-Za-z0-9_]*$", min: Int = 3, max: Int = 20) -> Self {
        
        let regexRule : ValidationRule<String> = self.regex(pattern, failedMessage: "Username can have numbers, letters and _ as special charecter")
        
        return .init { (value) -> (status: Bool, statusMessage: String) in
            
            if value.trimmed.count < min || value.trimmed.count > 20 {
                return (false, "Min 3, Max 20 charecters are allowed")
            }
            
            return regexRule.rule(value)
        }
    }
    
    static var nonEmpty: Self {
        return .init { (value) -> (status: Bool, statusMessage: String) in
            
            let result = value.trimmed.count != 0
            return (result, result ? "Non empty string" : "Value can not be empty")
        }
    }
}




