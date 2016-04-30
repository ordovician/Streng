//
//  DataExtensions.swift
//  Streng
//
//  Created by Erik Engheim on 30/04/16.
//  Copyright © 2016 Translusion. All rights reserved.
//

import Foundation

extension NSData {
    /// Create data from an array of bytes
    convenience init(bytes: [UInt8]) {
        self.init(bytes: bytes, length: bytes.count)
    }
    
    /// Data as an array of bytes
    var bytes: [UInt8] {
        let count = self.length / sizeof(UInt8)
        var outbytes: [UInt8] = [UInt8](count: count, repeatedValue: 0)
        self.getBytes(&outbytes, length:count * sizeof(UInt8))
        return outbytes
    }
}

/// Decodes the base64-encoded string and returns a [UInt8] of the decoded bytes
func base64decode(s: String) -> [UInt8]? {
    guard let indata = NSData(base64EncodedString: s, options: []) else { return nil }
    return indata.bytes
}

/// Encade binary data stored in bytes array into a base64 encoded string
func base64encode(bytes: [UInt8]) -> String {
    let data = NSData(bytes: bytes)
    return data.base64EncodedStringWithOptions([])
}