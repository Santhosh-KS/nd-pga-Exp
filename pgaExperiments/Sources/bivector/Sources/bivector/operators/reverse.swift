import Foundation

prefix operator |~|

public prefix func |~|<A:FloatingPoint>(_ item:(A,[e])) -> (A,[e]) {
  if item |> isCoefficientZero { return zeroVector() }
  else {
    // This Normalization is important.
    // more dtails in this discussion thread. https://discourse.bivector.net/t/why-there-is-no-inverse-operator-defined-in-bivector-net/608
    let itemGrade = item |> grade
    let val = normalized(item)
    if (itemGrade == 0 || itemGrade == 1 || itemGrade == 2 ) {
      return (val.0 * -1,  val.1  )
    }
    else { return val }
  }
}

public prefix func |~|<A:Numeric & FloatingPoint >(_ items:[(A,[e])]) -> [(A,[e])] {
  items.map(|~|)
}

public prefix func |~|<A:FloatingPoint>(_ item:(A,e)) -> (A,[e]) {
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


