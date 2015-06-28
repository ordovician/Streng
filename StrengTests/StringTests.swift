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
        XCTAssert(isHex("0"))
        XCTAssert(isHex("1"))
        XCTAssert(isHex("a"))
        XCTAssert(isHex("b"))
        XCTAssertFalse(isHex("x"))
        XCTAssertFalse(isHex("y"))
        XCTAssertFalse(isHex("hello world"))
        XCTAssert(isHex("0ff"))
        XCTAssert(isHex("f1"))
        XCTAssert(isHex("af2d"))
        XCTAssert(isHex("A98fA9"))
        XCTAssert(isHex("01"))
        XCTAssert(isHex("120"))
        XCTAssert(isHex("991"))
        XCTAssert(isHex("123456"))
        XCTAssert(isHex("53234"))
    }
    
    func testIsDigitSimple() {
        XCTAssert(isInt("0"))
        XCTAssert(isInt("1"))
        XCTAssertFalse(isInt("a"))
        XCTAssertFalse(isInt("b"))
        XCTAssertFalse(isInt("x"))
        XCTAssertFalse(isInt("y"))
        XCTAssertFalse(isInt("hello world"))
        XCTAssertFalse(isInt("0ff"))
        XCTAssertFalse(isInt("f1"))
        XCTAssertFalse(isInt("af2d"))
        XCTAssertFalse(isInt("A98fA9"))
        XCTAssert(isInt("01"))
        XCTAssert(isInt("120"))
        XCTAssert(isInt("991"))
        XCTAssert(isInt("123456"))
        XCTAssert(isInt("53234"))
    }
    
    func testRangeOf() {
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
                      index = td.haystack.search(td.needle) else {
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
    
    func testRSearch() {
        let s1 = "abcdefg"
        XCTAssertEqual(s1[s1.rsearch("efg")!], Character("e"))
        let s2 = "ab12ab34"
        let i2 = s2.rsearch("ab")!
        XCTAssert(s2[i2..<s2.endIndex].hasPrefix("ab34"))
    }
    
    func testSearch() {
        let s1 = "abcdefg"
        XCTAssertEqual(s1[s1.search("efg")!], Character("e"))
        let s2 = "ab12ab34"
        let i2 = s2.search("ab")!
        XCTAssert(s2[i2..<s2.endIndex].hasPrefix("ab12"))
    }
    
    func testPredicateSearchWhitespace() {
        let numbers = "one two three four five"
        let i = numbers.search(isWhitespace)!
        XCTAssertEqual(numbers[numbers.startIndex..<i], "one")
        let j = numbers.rsearch(isWhitespace)!
        XCTAssertEqual(numbers[j.successor()..<numbers.endIndex], "five")

    }
    
    func testPredicateSearchHex() {
        let hex = "ggggg01abgggg"
        let i = hex.search(isHex)!
        let j = hex.rsearch(isHex)!
        XCTAssertEqual(hex[i...j], "01ab")
    }
    
    func testRangeOfWord() {
        var w = "one two three four"
        let r = w.rangeOfWord(w.startIndex)
        XCTAssertEqual(w[r], "one")
        var i = advance(w.startIndex, 5)
        XCTAssertEqual(w[w.rangeOfWord(i)], "two")
        XCTAssertEqual(w[w.rangeOfWord(i.successor())], "two")
        i = advance(w.startIndex, 8)
        XCTAssertEqual(w[w.rangeOfWord(i)], "three")
        i = advance(w.startIndex, 17)
        XCTAssertEqual(w[w.rangeOfWord(i)], "four")
        
        w = "wholeword"
        i = w.startIndex
        XCTAssertEqual(w[w.rangeOfWord(i)], "wholeword")
        XCTAssertEqual(w[w.rangeOfWord(i.successor())], "wholeword")
        i = w.endIndex.predecessor()
        XCTAssertEqual(w[w.rangeOfWord(i)], "wholeword")
    }
    
}