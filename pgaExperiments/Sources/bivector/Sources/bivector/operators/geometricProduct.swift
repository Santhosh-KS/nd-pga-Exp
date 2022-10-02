import Foundation

precedencegroup GeometricProductProcessingOrder {
  associativity:left
  higherThan: AdditionEvaluation, ForwardApplication,
  RegressiveProductProcessingOrder, SandwichProductProcessingOrder
  lowerThan: MultiplicationPrecedence, AdditionPrecedence
}

infix operator |*|:GeometricProductProcessingOrder

public func |*|<A:Numeric>(_ lhs:A, _ rhs:A) -> A {
  lhs ||| rhs |+| lhs |^| rhs
}

public func |*|<A:Numeric>(_ lhs:[A], _ rhs:[A]) -> A {
  lhs ||| rhs |+| lhs |^| rhs
}

public func |*|<A:Numeric>(_ lhs:A, _ rhs:e) -> (A,e) {
  lhs |^| rhs
}

public func |*|<A:Numeric>(_ lhs:e, _ rhs:A) -> (A,e) {
  lhs |^| rhs
}

public func |*|<A:Numeric>(_ lhs:[A], _ rhs:e) -> (A,e) {
  lhs |^| rhs
}

public func |*|<A:Numeric>(_ lhs:e, _ rhs:[A]) -> (A,e) {
  rhs |^| lhs
}

public func |*|<A:Numeric> (_ lhs:(A,e), _ rhs:(A, e)) -> (A, [e]) {
  (lhs |^| rhs)
}

public func |*|<A:Numeric>(_ lhs:e, _ rhs:e) -> (A, [e]) {
  (lhs |> unit) |*| (rhs |> unit)
}

public func |*|<A:Numeric> (_ lhs:e, _ rhs:(A, e)) -> (A, [e]) {
  (lhs |> unit) |*| rhs
}

public func |*|<A:Numeric> (_ lhs:(A, e), _ rhs:e) -> (A, [e]) {
  lhs |*| (rhs |> unit)
}

public func |*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,[e])) -> [(A, [e])] {
  (lhs ||| rhs |+| lhs |^| rhs) |> compactMap
}

public func |*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,e)) -> [(A, [e])] {
  lhs |*| (rhs |> arrayfySecond)
}

public func |*|<A:Numeric>(_ lhs:(A,e), _ rhs:(A,[e])) -> [(A, [e])] {
  (lhs |> arrayfySecond) |*| rhs
}

public func |*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:e) -> [(A, [e])] {
  lhs |*| (rhs |> arrayfy)
}

public func |*|<A:Numeric>(_ lhs:e, _ rhs: (A,[e])) -> [(A, [e])] {
  (lhs |> arrayfy) |*| rhs
}

public func |*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:[e]) -> [(A, [e])] {
  lhs |*| (rhs |> unit)
}

public func |*|<A:Numeric>(_ lhs:[e], _ rhs: (A,[e])) -> [(A, [e])] {
  (lhs |> unit) |*| rhs
}

public func |*|<A:Numeric>(_ lhs:[e], _ rhs: [e]) -> [(A, [e])] {
  (lhs |> unit) |*| (rhs |> unit)
}

public func |*|<A:Numeric>(_ lhs:A, _ rhs:(A,[e])) -> (A, [e]) {
  ((lhs, []) |*| rhs).first!
}

public func |*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:A) -> (A, [e]) {
  (lhs |*| (rhs, [])).first!
}

public func |*|<A:Numeric>(_ lhs:[(A,[e])], _ rhs:[(A,[e])]) -> [(A, [e])] {
  var retVal = [(A, [e])]()
  for lmlv in lhs {
    for rmlv in rhs {
      let prod = (lmlv |*| rmlv)
      if !prod.isEmpty { retVal.append(prod.first!)}
    }
  }
  return reduce(with: |+|, retVal) |> compactMap
}

public func |*|<A:Numeric> (_ lhs:A, _ rhs:(A, e)) -> (A,e) {
  (lhs|*|rhs.0, rhs.1)
}

public func |*|<A:Numeric> (_ lhs:(A,e), _ rhs:A) -> (A, e) {
  (lhs.0|*|rhs, lhs.1)
}

