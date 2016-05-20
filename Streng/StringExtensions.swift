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

/// Check if string is valid base64 string. That means it contains
/// A-Z, a-z, 1-0, + or / and ends with one or two = symbols
public func isBase64(string: String) -> Bool {
    var charCountAfterTerminator: Int = 0
    var foundTerminator = false
    for ch in string.characters {
        if foundTerminator {
            charCountAfterTerminator += 1
            if charCountAfterTerminator >= 3 || ch != "=" {
                return false
            }
        } else if ch == "=" {
            charCountAfterTerminator = 1
            foundTerminator = true
        } else if !isBase64(ch) {
            return false
        }
    }
    return true
}

// TODO: Needs testing
/// Do an in place replacement of all `strings` found in files in `paths` replacing them with the string
/// produced with `replacer`. Warning don't do this on files unless they have been backed up.
public func replace(strings: [String], inFilePaths paths: [String], using replacer: String->String) throws {
    for path in paths {
        var text = try String(contentsOfFile: path)
        for needle in strings {
            text = text.stringByReplacingOccurrencesOfString(needle, withString: replacer(needle))
            try text.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
        }
    }
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
            return i..<i.advancedBy(len)
        }
        
        return nil
    }
    
    /// Split string into an array of strings using separator. If we get no
    public func split(separator: String) -> [String] {
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
    public func rangeOfWord(caret: Index, predicate: (Character)->Bool = isWhitespace) -> Range<Index> {
        let i = self.rsearch(caret, predicate: predicate)?.successor() ?? startIndex
        let j = self.search(caret, predicate: predicate) ?? endIndex
        return i..<j
    }
    
    /// Obfuscate string by changing every byte with function `f` and storing result as base64 encoding
    public func obfuscated(f: UInt8->UInt8) -> String {
        let bytes = Array(self.utf8).map(f)
        return base64encode(bytes)
    }
    
    /// Deobfuscate base64 decode transform each byte with f and return result as UTF8 encoded
    public func deobfuscate(f: UInt8->UInt8) -> String? {
        let inbytes = base64decode(self)
        let outbytes = inbytes.map { bytes in bytes.map(f) }
        return outbytes.flatMap { bytes in String(bytes: bytes, encoding: NSUTF8StringEncoding) }
    }
}
