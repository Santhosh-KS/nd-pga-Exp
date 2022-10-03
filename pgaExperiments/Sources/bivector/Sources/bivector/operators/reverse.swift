import Foundation

prefix operator |~|

public prefix func |~|<A:FloatingPoint>(_ item:(A,[e])) -> (A,[e]) {
  if item.1.isEmpty { return (1, []) }
  // This Normalization is important.
  // more dtails in this discussion thread. https://discourse.bivector.net/t/why-there-is-no-inverse-operator-defined-in-bivector-net/608
  let val = normalized(item)
  if (grade(item) != 2) { return item }
  return (val.0, val.1 == [e(0)] ? [] : val.1  )
}

public prefix func |~|<A:Numeric & FloatingPoint >(_ items:[(A,[e])]) -> [(A,[e])] {
  items.map(|~|)
}

public prefix func |~|<A:FloatingPoint>(_ item:(A,e)) -> (A,[e]) {
//  return (item.0 * -1, item.1)
  |~|(item |> arrayfySecond)
}

public prefix func |~|<A:FloatingPoint>(_ items:[(A,e)]) -> [(A,[e])] {
  items.map(|~|)
}

public prefix func |~|<A:FloatingPoint>(_ item:e) -> (A,[e]) {
  |~|(item |> unitVector |> arrayfySecond )
}

public prefix func |~|<A:FloatingPoint>(_ item:[e]) -> (A,[e]) {
 |~|(item |> unitVector)
}

public prefix func |~|<A:FloatingPoint>(_ item:A) -> A {
  item
}

public func reverse<A:FloatingPoint>(of item:(A,[e])) -> (A,[e]) {
  |~|item
}

public func reverse<A:FloatingPoint>(of items:[(A,[e])]) -> [(A,[e])] {
  |~|items
}

public func reverse<A:FloatingPoint>(of item:(A,e)) -> (A,[e]) {
  |~|item
}

public func reverse<A:FloatingPoint>(of item:[(A,e)]) -> [(A,[e])] {
  |~|item
}

public func reverse<A:FloatingPoint>(of item:e) -> (A,[e]) {
  |~|item
}

public func reverse<A:FloatingPoint>(of item:[e]) -> (A,[e]) {
  |~|item
}

public func reverse<A:FloatingPoint>(of item:A) -> A {
  |~|item
}


