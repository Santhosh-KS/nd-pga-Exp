import Foundation

precedencegroup GeometricProductProcessingOrder {
  associativity:left
  higherThan: AdditionEvaluation, ForwardApplication,
  RegressiveProductProcessingOrder, SandwichProductProcessingOrder
  lowerThan: MultiplicationPrecedence, AdditionPrecedence
}

// a  *  b = a . b + a ^ b -- (1)
// a |*| b = a|||b + a|^|b --> Notation Convention equivalent of eq(1)

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
  (1,lhs) |*| (1,rhs)
}

public func |*|<A:Numeric> (_ lhs:e, _ rhs:(A, e)) -> (A, [e]) {
  (1,lhs) |*| rhs
}

public func |*|<A:Numeric> (_ lhs:(A, e), _ rhs:e) -> (A, [e]) {
  lhs |*| (1, rhs)
}

public func |*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,[e])) -> [(A, [e])] {
  (lhs ||| rhs |+| lhs |^| rhs) |> compactMap
}

public func |*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,e)) -> [(A, [e])] {
  lhs |*| (rhs |> arrafySecond)
}

public func |*|<A:Numeric>(_ lhs:(A,e), _ rhs:(A,[e])) -> [(A, [e])] {
  (lhs |> arrafySecond) |*| rhs
}

public func |*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:e) -> [(A, [e])] {
  lhs |*| (1, [rhs])
}

public func |*|<A:Numeric>(_ lhs:e, _ rhs: (A,[e])) -> [(A, [e])] {
  (1, [lhs]) |*| rhs
}

public func |*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:[e]) -> [(A, [e])] {
  lhs |*| (1, rhs)
}

public func |*|<A:Numeric>(_ lhs:[e], _ rhs: (A,[e])) -> [(A, [e])] {
  (1, lhs) |*| rhs
}

public func |*|<A:Numeric>(_ lhs:[e], _ rhs: [e]) -> [(A, [e])] {
  (1, lhs) |*| (1, rhs)
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

