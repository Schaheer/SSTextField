//
//  String+Ext.swift
//  SSTextField
//
//  Created by Schaheer on 17/09/2023.
//

import Foundation

extension String {
    
    ///To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    /// Check that the string text is a valid email type
    func isValidEmail() -> Bool {
        if self.isBlank {
            return false
        }
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        let result =  emailPredicate.evaluate(with: self)
        
        return result
    }
    
}
