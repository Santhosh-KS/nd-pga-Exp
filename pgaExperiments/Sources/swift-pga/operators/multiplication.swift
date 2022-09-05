import Foundation

precedencegroup multiplicationProcessingOrder {
  associativity:left
  higherThan: additionEvaluation, ForwardApplication
  lowerThan: MultiplicationPrecedence, AdditionPrecedence
}

// a  *  b = a . b + a ^ b -- (1)
// a |*| b = a|||b + a|^|b --> Notation Convention equivalent of eq(1)

infix operator |*|:multiplicationProcessingOrder

public func |*|<A:Numeric>(_ lhs:A, _ rhs:A) -> A {
  lhs ||| rhs |+| lhs |^| rhs
}

public func |*|<A:Numeric>(_ lhs:[A], _ rhs:[A]) -> A {
  zip2(with: |*|)(lhs, rhs).reduce(1, |*|)
}

public func |*|<A:Numeric> (_ lhs:e, _ rhs:e) -> [(A, [e])] {
  (lhs ||| rhs ) |+| (A.zero + 1, lhs |^| rhs)
}

public func |*|<A:Numeric> (_ lhs:[e], _ rhs:[e]) -> [[(A, [e])]] {
  zip2(with: |*|)(lhs, rhs)
}

public func |*|<A:Numeric> (_ lhs:A, _ rhs:e) -> (A,e) {
  (lhs ||| rhs)  |+| (lhs |^| rhs)
}

public func |*|<A:Numeric> (_ lhs:[A], _ rhs:[e]) -> [(A,e)] {
  zip2(with: |*|)(lhs, rhs)
}

public func |*|<A:Numeric> (_ lhs:e, _ rhs:A) -> (A,e) {
  (lhs ||| rhs)  |+| (lhs |^| rhs)
}

public func |*|<A:Numeric> (_ lhs:[e], _ rhs:[A]) -> [(A,e)] {
  zip2(with: |*|)(lhs, rhs)
}
//
//public func |*|<A:Numeric>(_ lhs:A, _ rhs:e) -> (A,e) {
//  lhs ||| rhs |+| lhs |^| rhs
//}
//
//public func |*|<A:Numeric>(_ lhs:[A], _ rhs:[e]) -> [(A,e)] {
//  zip2(with: |*|)(lhs, rhs)
//}
//
//
//public func |*|<A:Numeric>(_ lhs:e, _ rhs:A) -> (A,e) {
//  rhs |^| lhs
//}
//
//public func |*|<A:Numeric>(_ lhs:[e], _ rhs:[A]) -> [(A,e)] {
//  zip2(with: |*|)(lhs, rhs)
//}
