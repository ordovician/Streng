[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# Streng

Streng is Norwegian for String and is a set of `Character` and `String` extensions to Swift strings. The `String` class in swift is quite slim on functionality that frankly ought to be there, so this is an attempt to add the missing pieces. One of the design goals is to avoid adding functions going against Apple's design goals for the String class. E.g. many people would add function allowing integer access of String characters. However Apple intentionally did not add that as random access is not done in constant time on swift strings and should thus be avoided.

Some Streng extensions will try to stick to using `String.Index` for specifying positions in strings.

# Install using Carthage

If you haven't already created one, create a file named `Cartfile` in your project root directory and add the line:

    github "ordovician/Streng"

To make Carthage download and compile package write:

    $ carthage update


