//
//  StringExtensions.swift
//  Streng
//
//  Created by Erik Engheim on 14/06/15.
//  Copyright © 2015 Translusion. All rights reserved.
//

import Foundation

/// Check if string represents a hexadecimal number. E.g. 1af2, ff, 234 and 120 are all hexadecimal numbers.
public func isHex(string: String) -> Bool {
    for ch in string.characters where !isHex(ch) {
        return false
    }
    return true
}

/// Check if string represents an integer number.
public func isInt(string: String) -> Bool {
    for ch in string.characters where !isDigit(ch) {
        return false
    }
    return true
}

/// Methods that ought to be supplemented as standard to the String class
public extension String {

    /// Locate index of chars
    public func search(chars: String) -> String.Index? {
        return self.search(chars, start: startIndex)
    }
    
    /// Locate index of chars starting at start index
    public func search(chars: String, start: Index) -> Index? {
        for i in start..<endIndex {
            if self[i..<endIndex].hasPrefix(chars) {
                return i
            }
        }
        return nil
    }
    
    public func search(predicate: (Character)->Bool) -> Index? {
        return search(startIndex, predicate: predicate)
    }
    
    /// Search for index of character matching predicate
    public func search(start: Index, predicate: (Character)->Bool) -> Index? {
        for i in start..<endIndex {
            if predicate(self[i]) {
                return i
            }
        }
        return nil
    }
    
    /// Search for index of character matching predicate
    public func rsearch(start: Index, predicate: (Character)->Bool) -> Index? {
        for i in (startIndex..<start).reverse() {
            if predicate(self[i]) {
                return i
            }
        }
        return nil
    }
    
    public func rsearch(predicate: (Character)->Bool) -> Index? {
        return rsearch(endIndex, predicate: predicate)
    }
    
    
    /// Search backwards for the occurance of chars starting at index
    public func rsearch(chars: String, start: Index) -> Index? {
        let range = (startIndex..<start).reverse()
        for i in range {
            if self[i..<endIndex].hasPrefix(chars) {
                return i
            }
        }
        
        return nil
    }
    
    public func rsearch(chars: String) -> Index? {
        return self.rsearch(chars, start: endIndex)
    }
    
    
    /// Find range of chars in string
    public func rangeOf(chars: String) -> Range<Index>? {
        return self.rangeOf(chars, start: startIndex)
    }
    
    /// Find range of chars starting at start index
    public func rangeOf(chars: String, start: Index) -> Range<Index>? {
        let len = chars.characters.count
        if let i = search(chars, start: start) {
            return Range(start: i, end: i.advancedBy(len))
        }
        
        return nil
    }
    
    /// Split string into an array of strings using separator. If we get no
    func split(separator: String) -> [String] {
        var result: [String] = []
        var i = startIndex
        repeat {
            guard let range = self.rangeOf(separator, start: i) else {
                result.append(self[i..<endIndex])
                break
            }
            assert(i <= range.startIndex)
            result.append(self[i..<range.startIndex])
            i = range.endIndex
        } while i < endIndex
        
        return result
    }
    
    /// Assume caret is in the middle of a word, and we want to find the start and end index
    /// of this word. The word boundaries is defined by a predicate, so it could be whitespace by
    /// providing `isWhitespace` e.g.
    func rangeOfWord(caret: Index, predicate: (Character)->Bool = isWhitespace) -> Range<Index> {
        let i = self.rsearch(caret, predicate: predicate)?.successor() ?? startIndex
        let j = self.search(caret, predicate: predicate) ?? endIndex
        return Range(start: i, end: j)
    }
}
