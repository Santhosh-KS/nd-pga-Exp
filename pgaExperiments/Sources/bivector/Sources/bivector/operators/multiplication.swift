import Foundation

precedencegroup MultiplicationProcessingOrder {
  associativity:left
  higherThan: AdditionEvaluation, ForwardApplication
  lowerThan: MultiplicationPrecedence, AdditionPrecedence
}

// a  *  b = a . b + a ^ b -- (1)
// a |*| b = a|||b + a|^|b --> Notation Convention equivalent of eq(1)

infix operator |*|:MultiplicationProcessingOrder

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

func |*|<A:Numeric>(_ lhs:e, _ rhs:e) -> (A, [e]){
  lhs |^| rhs
}

public func |*|<A:Numeric> (_ lhs:(A,e), _ rhs:(A, e)) -> (A, [e]) {
  lhs |^| rhs
}

func |*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,[e])) -> [(A, [e])] {
  (lhs ||| rhs |+| lhs |^| rhs) |> compactMap
}

func |*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,e)) -> [(A, [e])] {
  lhs |*| (rhs.0, [rhs.1])
}

func |*|<A:Numeric>(_ lhs:(A,e), _ rhs:(A,[e])) -> [(A, [e])] {
  (lhs.0, [lhs.1]) |*| rhs
}

func |*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:e) -> [(A, [e])] {
  lhs |*| (1, [rhs])
}

func |*|<A:Numeric>(_ lhs:e, _ rhs: (A,[e])) -> [(A, [e])] {
  (1, [lhs]) |*| rhs
}

func |*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:[e]) -> [(A, [e])] {
  lhs |*| (1, rhs)
}

func |*|<A:Numeric>(_ lhs:[e], _ rhs: (A,[e])) -> [(A, [e])] {
  (1, lhs) |*| rhs
}
