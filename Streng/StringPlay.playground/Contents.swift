//: Playground - noun: a place where people can play

import Streng

var str = "Hello, playground"

let num = "erik123eng56"

num.characters.reduce("") { result, ch in

    return result + String(ch)
}


let xs = num.characters.filter(isDigit).map { String($0) }
xs.joinWithSeparator("")

let meet = "Please dial into https://meet.dailyplanet.com/clark/Y68ZVPW9 using whatever client you have to hand (host PIN 3678#, guest PIN 1534#)."


/// Turn https://meet.gotham.com/batman/Y68ZVPW9 into
/// batman@gotham.com;gruu;opaque=app;conf:focus:id:Y68ZVPW9
func extractGatewayURI(s: String) -> String? {
    guard let j = s.search("://") else { return nil }
    guard let i = s.rsearch(j, predicate: isWhitespace) else { return nil }
    let prot = s[i.successor()..<j].lowercaseString
    guard prot.hasPrefix("http") else { return nil }
    
    // get the part following https://
    guard let k = s.search(j, predicate: isAlpha) else { return nil }
    guard let l = s.search(k, predicate: isWhitespace) else { return nil }
    let address = s[k..<l]
    let parts = address.split("/")
    guard parts.count == 3 else { return nil }
    
    // remove prefix part of host. Typically meet.
    let hostparts = parts[0].split(".")
    let host = hostparts[1..<hostparts.endIndex].joinWithSeparator(".")
    
    let conf = parts[1]
    let ident = parts[2]
    
    return "\(conf)@\(host);gruu;opaque=app;conf:focus:id:\(ident)"
}

extractGatewayURI(meet)