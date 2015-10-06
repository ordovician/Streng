//
//  CharacterExtensions.swift
//  Streng
//
//  Created by Erik Engheim on 14/06/15.
//  Copyright © 2015 Translusion. All rights reserved.
//

import Foundation

/// Check character classes. E.g. whether character is a letter or a number
/// Is character a digit
public func isDigit(char: Character) -> Bool {
    return char >= "0" && char <= "9"
}

/// Is character an upper case letter
public func isUpper(char: Character) -> Bool {
    return char >= "A" && char <= "Z"
}

/// Is character a lower case letter
public func isLower(char: Character) -> Bool {
    return char >= "a" && char <= "z"
}

/// Only checks if letters are part of standard english alphabet (ASCII)
public func isAlpha(char: Character) -> Bool {
    return isUpper(char) || isLower(char)
}

/// Is character a letter in the alphabet or a number
public func isAlphaNum(char: Character) -> Bool {
    return isDigit(char) || isAlpha(char)
}

/// Check if character is A-Za-z0-9
public func isHex(char: Character) -> Bool {
    return isDigit(char) || char >= "A" && char <= "F" || char >= "a" && char <= "f"
}

/// Check if character is a whitespace character: space, tab, newline
public func isWhitespace(char: Character) -> Bool {
    for ch in " \n\t".characters where char == ch {
        return true
    }
    return false
}

/// Does character one of the characters used for base64 encoding?
public func isBase64(char: Character) -> Bool {
    return isDigit(char) || char >= "A" && char <= "Z" || char >= "a" && char <= "z" || char == "+" || char == "/"
}