//
//  CharacterExtensions.swift
//  Streng
//
//  Created by Erik Engheim on 14/06/15.
//  Copyright © 2015 Translusion. All rights reserved.
//

import Foundation

/// Check character classes. E.g. whether character is a letter or a number
public extension Character {
    /// Is character a digit
    public var isDigit: Bool {
        return self >= "0" && self <= "9"
    }
    
    /// Is character an upper case letter
    public var isUpper: Bool {
        return self >= "A" && self <= "Z"
    }
    
    /// Is character a lower case letter
    public var isLower: Bool {
        return self >= "a" && self <= "z"
    }
    
    /// Only checks if letters are part of standard english alphabet (ASCII)
    public var isAlpha: Bool {
        return self.isUpper || self.isLower
    }
    
    /// Is character a letter in the alphabet or a number
    public var isAlphaNum: Bool {
        return self.isDigit || self.isAlpha
    }
    
    /// Check if character is A-Za-z0-9
    public var isHex: Bool {
        return self.isDigit || self >= "A" && self <= "F" || self >= "a" && self <= "f"
    }
    
    public func unicodeValue() -> UInt32 {
        for s in String(self).unicodeScalars {
            return s.value
        }
        return 0
    }
}