import Foundation

infix operator |^|:GeometricProductProcessingOrder

public func |^|<A:Numeric> (_ lhs:A, _ rhs:A) -> A {
  A.zero
}

public func |^|<A:Numeric> (_ lhs:[A], _ rhs:[A]) -> A {
  A.zero
}

public func |^|<A:Numeric> (_ lhs:A, _ rhs:e) -> (A, e) {
  (lhs, rhs)
}

public func |^|<A:Numeric> (_ lhs:e, _ rhs:A) -> (A, e) {
  rhs |^| lhs
}

public func |^|<A:Numeric> (_ lhs:[A], _ rhs:e) -> (A, e) {
  (lhs.reduce(1, |^|), rhs)
}

public func |^|<A:Numeric> (_ lhs:e, _ rhs:[A]) -> (A, e) {
  rhs |^| lhs
}

public func |^|<A:Numeric> (_ lhs:(A,e), _ rhs:(A, e)) -> (A, [e]) {
  (lhs, rhs) |> (process >>> normalized)
}

public func |^|<A:Numeric> (_ lhs:e, _ rhs:e) -> (A, [e]) {
  (lhs |> unitVector) |^| (rhs |> unitVector)
}

public func |^|<A:Numeric> (_ lhs:(A,[e]), _ rhs:(A, [e])) -> (A, [e]) {
  if  lhs.1.sorted() == rhs.1.sorted() { return (0, []) }
  for re in rhs.1 {
    if contains(lhs.1, re) { return (0, []) }
  }
  return normalized((lhs.0*rhs.0, lhs.1 + rhs.1))
}

func |^|<A:Numeric>(_ lhs:[(A,[e])], _ rhs:[(A,[e])]) -> [(A, [e])] {
  var retVal = [(A, [e])]()
  for lmlv in lhs {
    for rmlv in rhs {
      retVal.append((lmlv |^| rmlv))
    }
  }
  return retVal |> compactMap
}

public func |^|<A:Numeric> (_ lhs:(A,[e]), _ rhs:(A, e)) -> (A, [e]) {
  lhs |^| (rhs |> arrayfySecond)
}

public func |^|<A:Numeric> (_ lhs:(A, e), _ rhs:(A,[e])) -> (A, [e]) {
  (lhs |> arrayfySecond) |^| rhs
}

public func |^|<A:Numeric> (_ lhs:(A,[e]), _ rhs: e) -> (A, [e]) {
  lhs |^| (rhs |> unitVector >>> arrayfySecond)
}

public func |^|<A:Numeric> (_ lhs:e, _ rhs: (A,[e])) -> (A, [e]) {
  (lhs |> unitVector) |^| rhs
}

public func |^|<A:Numeric> (_ lhs:(A,[e]), _ rhs: [e]) -> (A, [e]) {
  lhs |^| (rhs |> unitVector)
}

public func |^|<A:Numeric> (_ lhs:[e], _ rhs: (A,[e])) -> (A, [e]) {
  (lhs |> unitVector) |^| rhs
}

public func |^|<A:Numeric> (_ lhs:[e], _ rhs: [e]) -> (A, [e]) {
  (lhs |> unitVector) |^| (rhs |> unitVector)
}
public func |^|<A:Numeric> (_ lhs:A, _ rhs:(A, e)) -> (A,e) {
  (lhs*rhs.0, rhs.1)
}

public func |^|<A:Numeric> (_ lhs:(A,e), _ rhs:A) -> (A, e) {
  (lhs.0*rhs, lhs.1)
}

public func |^|<A:Numeric> (_ lhs:A, _ rhs:(A, [e])) -> (A,[e]) {
  (lhs*rhs.0, rhs.1)
}

public func |^|<A:Numeric> (_ lhs:(A,[e]), _ rhs:A) -> (A, [e]) {
  (lhs.0*rhs, lhs.1)
}
