//
//  StringTests.swift
//  Streng
//
//  Created by Erik Engheim on 14/06/15.
//  Copyright © 2015 Translusion. All rights reserved.
//

import Foundation
import XCTest
import Streng

class StringTests: XCTestCase {
    
    
    func testIsHexSimple() {
        XCTAssert("0".isHex)
        XCTAssert("1".isHex)
        XCTAssert("a".isHex)
        XCTAssert("b".isHex)
        XCTAssertFalse("x".isHex)
        XCTAssertFalse("y".isHex)
        XCTAssertFalse("hello world".isHex)
        XCTAssert("0ff".isHex)
        XCTAssert("f1".isHex)
        XCTAssert("af2d".isHex)
        XCTAssert("A98fA9".isHex)
        XCTAssert("01".isHex)
        XCTAssert("120".isHex)
        XCTAssert("991".isHex)
        XCTAssert("123456".isHex)
        XCTAssert("53234".isHex)
    }
    
    func testIsDigitSimple() {
        XCTAssert("0".isInt)
        XCTAssert("1".isInt)
        XCTAssertFalse("a".isInt)
        XCTAssertFalse("b".isInt)
        XCTAssertFalse("x".isInt)
        XCTAssertFalse("y".isInt)
        XCTAssertFalse("hello world".isInt)
        XCTAssertFalse("0ff".isInt)
        XCTAssertFalse("f1".isInt)
        XCTAssertFalse("af2d".isInt)
        XCTAssertFalse("A98fA9".isInt)
        XCTAssert("01".isInt)
        XCTAssert("120".isInt)
        XCTAssert("991".isInt)
        XCTAssert("123456".isInt)
        XCTAssert("53234".isInt)
    }
    
    func testIndexOf() {
        struct TestData {
            var needle: String
            var haystack: String
        }
        
        for td  in [TestData(needle: "bar"  , haystack: "foobar"),
                    TestData(needle: "spam" , haystack: "spam and eggs"),
                    TestData(needle: "cde" , haystack: "abcdefghijk"),
                    TestData(needle: "batman" , haystack: "the joker and batman drove to arkham"),
                    TestData(needle: "456" , haystack: "12345678"),
                    TestData(needle: "!å:" , haystack: "#$%&^)!å:æ")]

        {
            guard let range = td.haystack.rangeOf(td.needle),
                      index = td.haystack.indexOf(td.needle) else {
                XCTFail("Did not find '\(td.needle)' in '\(td.haystack)'")
                continue
            }
            XCTAssertEqual(td.needle, td.haystack[range])
            XCTAssert(td.haystack[index..<td.haystack.endIndex].hasPrefix(td.needle))
        }
        
    }
    
    func testSplit() {
        let empty: [String] = [""]
        XCTAssertEqual("".split(""), empty)
        XCTAssertEqual("foobar".split("batman"), ["foobar"])
        XCTAssertEqual("foo:bar".split(":"), ["foo", "bar"])
        XCTAssertEqual("batman and robin".split(" and "), ["batman", "robin"])
        XCTAssertEqual("1sep2sep3sep4".split("sep"), ["1", "2", "3", "4"])
        XCTAssertEqual("1sep2sep3sep4sep".split("sep"), ["1", "2", "3", "4"])
    }
    
}