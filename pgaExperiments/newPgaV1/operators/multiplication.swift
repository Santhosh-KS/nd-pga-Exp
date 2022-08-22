import Foundation

precedencegroup multiplicationProcessingOrder {
  associativity:left
  higherThan: additionEvaluation
  lowerThan: MultiplicationPrecedence, AdditionPrecedence
}

// a  *  b = a . b + a ^ b -- (1)
// a |*| b = a|||b + a|^|b --> Notation Convention equivalent of eq(1)

infix operator |*|:multiplicationProcessingOrder


public func |*| (_ lhs:Float, _ rhs:Float) -> (Float, [e]) {
  (lhs*rhs, [])
}

public func |*| (_ lhs:[Float], _ rhs:[Float]) -> (Float, [e]) {
  var prod:Float = 1
  zip2(with: |*|)(lhs, rhs).forEach { (val:Float, _) in
    prod *= val
  }
  return (prod, [])
}

public func |*| (_ lhs:Float, _ rhs:(Float, e)) -> (Float, [e]) {
  (lhs*rhs.0, [rhs.1])
}

public func |*| (_ lhs:[Float], _ rhs:[(Float, e)]) -> [(Float, [e])] {
  zip2(with: |*|) (lhs, rhs)
}

public func |*| (_ lhs:(Float, e), _ rhs:Float) -> (Float, [e]) {
  rhs |*| lhs
}

public func |*| (_ lhs:[(Float, e)], _ rhs:[Float]) -> [(Float, [e])] {
  rhs |*| lhs
}

public func |*| (_ lhs:e, _ rhs:(Float, e)) -> (Float, [e]) {
  (rhs.0, [lhs, rhs.1])
}

public func |*| (_ lhs:(Float, e), _ rhs:e) -> (Float, [e]) {
  (lhs.0, [lhs.1, rhs])
}

public func |*| (_ lhs:[(Float, e)], _ rhs:[e]) -> [(Float, [e])] {
  zip2(with: |*|)(lhs,rhs)
}

public func |*| (_ lhs:e, _ rhs:e) -> (Float, [e]) {
  (1, [lhs,rhs])
}

public func |*| (_ lhs:[e], _ rhs:[e]) -> [(Float, [e])] {
  zip2(with: |*|)(lhs,rhs)
}

public func |*| (_ lhs:(Float, e), _ rhs:(Float, e)) -> (Float, [e]) {
  (lhs.0*rhs.0, [lhs.1, rhs.1])
}

public func |*| (_ lhs:[(Float, e)], _ rhs:[(Float, e)]) -> [(Float, [e])] {
  zip2(with: |*|)(lhs,rhs)
}
