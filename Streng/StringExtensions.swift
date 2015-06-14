//
//  StringExtensions.swift
//  Streng
//
//  Created by Erik Engheim on 14/06/15.
//  Copyright © 2015 Translusion. All rights reserved.
//

import Foundation

/// Methods that ought to be supplemented as standard to the String class
public extension String {
    /// Check if string represents an integer number.
    public var isInt: Bool {
        for ch in self.characters where !ch.isDigit {
            return false
        }
        return true
    }
    
    /// Check if string represents a hexadecimal number. E.g. 1af2, ff, 234 and 120 are all hexadecimal numbers.
    public var isHex: Bool {
        for ch in self.characters where !ch.isHex {
            return false
        }
        return true
    }
    
    /// Locate index of chars
    public func indexOf(chars: String) -> String.Index? {
        return self.indexOf(chars, start: startIndex)
    }
    
    /// Locate index of chars starting at start index
    public func indexOf(chars: String, start: Index) -> Index? {
        for i in start..<self.endIndex {
            if self[i..<self.endIndex].hasPrefix(chars) {
                return i
            }
        }
        
        return nil
    }
    
    /// Find range of chars in string
    public func rangeOf(chars: String) -> Range<Index>? {
        return self.rangeOf(chars, start: startIndex)
    }
    
    /// Find range of chars starting at start index
    public func rangeOf(chars: String, start: Index) -> Range<Index>? {
        let len = chars.characters.count
        if let i = indexOf(chars, start: start) {
            return Range(start: i, end: advance(i, len))
        }
        
        return nil
    }
    
    /// Split string into an array of strings using separator. If we get no 
    func split(separator: String) -> [String] {
        var result: [String] = []
        var i = startIndex
        repeat {
            guard var range = self.rangeOf(separator, start: i) else {
                result.append(self[i..<endIndex])
                break
            }
            assert(i <= range.startIndex)
            result.append(self[i..<range.startIndex])
            i = range.endIndex
        } while i < endIndex
        
        return result
    }
}