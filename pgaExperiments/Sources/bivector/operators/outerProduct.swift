import Foundation

infix operator |^|:MultiplicationProcessingOrder

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
  process(lhs, rhs) |> normalized
}

public func |^|<A:Numeric> (_ lhs:e, _ rhs:e) -> (A, [e]) {
  (1, lhs) |^| (1, rhs)
}

public func |^|<A:Numeric> (_ lhs:(A,[e]), _ rhs:(A, [e])) -> (A, [e]) {
  if  lhs.1.sorted() == rhs.1.sorted() { return (0, []) }
  for re in rhs.1 {
    if contains(lhs.1, re) { return (0, []) }
  }
  return normalized((lhs.0*rhs.0, lhs.1 + rhs.1))
}

