//: Playground - noun: a place where people can play

import Streng

var str = "Hello, playground"

let num = "erik123eng56"

num.characters.reduce("") { result, ch in

    return result + String(ch)
}


let xs = num.characters.filter(isDigit).map { String($0) }
xs.joinWithSeparator("")