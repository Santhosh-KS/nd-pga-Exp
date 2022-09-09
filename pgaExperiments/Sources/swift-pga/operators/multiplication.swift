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
  lhs ||| rhs |+| lhs |^| rhs
}

public func |*|(_ lhs:e, _ rhs:e) -> [e] {
  lhs |^| rhs
}

public func |*|<A:Numeric> (_ lhs:[e], _ rhs:[e]) -> [(A, [e])] {
 reduce(with: |*|, zip2(with: |*|)(lhs, rhs))
}

public func |*|<A:Numeric> (_ lhs:A, _ rhs:e) -> [(A,e)] {
  lhs ||| rhs |+| lhs |^| rhs
}

public func |*|<A:Numeric> (_ lhs:[A], _ rhs:[e]) -> [(A,e)] {
  reduce(with: |*|, zip2(with: |*|)(lhs, rhs))
}

public func |*|<A:Numeric> (_ lhs:e, _ rhs:A) -> [(A,e)] {
  lhs ||| rhs |+| lhs |^| rhs
}

public func |*|<A:Numeric> (_ lhs:[e], _ rhs:[A]) -> [(A,e)] {
  reduce(with: |*|, zip2(with: |*|)(lhs, rhs))
}

public func|*|<A:Numeric> (_ lhs:(A,e), _ rhs: (A,e)) -> [(A, [e])] {
  lhs ||| rhs |+|  (lhs |^| rhs)
}

public func|*|<A:Numeric> (_ lhs:[(A,e)], _ rhs: [(A,e)]) -> [(A, [e])] {
  reduce(with: |*|, zip2(with: |*|)(lhs, rhs))
}

//'Double' and '(Double, e)'
public func|*|<A:Numeric> (_ lhs:A, _ rhs:(A,e)) -> [(A,e)] {
  lhs ||| rhs |+| lhs |^| rhs
}

public func|*|<A:Numeric> (_ lhs:[A], _ rhs:[(A,e)]) -> [(A,e)] {
  reduce(with: |*|, zip2(with: |*|)(lhs, rhs))
}

public func|*|<A:Numeric> (_ lhs:(A,e), _ rhs:A) -> [(A,e)] {
  rhs |*| lhs
}

public func|*|<A:Numeric> (_ lhs:[(A,e)], _ rhs:[A]) -> [(A,e)] {
  reduce(with: |*|, zip2(with: |*|)(lhs, rhs))
}

public func|*|<A:Numeric> (_ lhs:(A,[e]), _ rhs:(A,e)) -> [(A, [e])] {
  lhs ||| rhs |+|  (lhs |^| rhs)
}

public func|*|<A:Numeric> (_ lhs:[(A,[e])], _ rhs:[(A,e)]) -> [(A, [e])] {
  reduce(with: |*|, zip2(with: |*|)(lhs, rhs))
}

public func|*|<A:Numeric> (_ lhs:(A,e), _ rhs:(A,[e])) -> [(A, [e])] {
  lhs ||| rhs |+| lhs |^| rhs
}

public func|*|<A:Numeric> (_ lhs:[(A,e)], _ rhs:[(A,[e])]) -> [(A, [e])] {
  reduce(with: |*|, zip2(with: |*|)(lhs, rhs))
}

public func|*|<A:Numeric> (_ lhs:[(A,[e])], _ rhs:(A,e)) -> [(A, [e])] {
  lhs ||| rhs |+| lhs |^| rhs
}

public func|*|<A:Numeric> (_ lhs:[[(A,[e])]], _ rhs:[(A,e)]) -> [(A, [e])] {
  reduce(with: |*|, zip2(with: |*|)(lhs, rhs))
}

public func|*|<A:Numeric> (_ lhs:(A,e), _ rhs:[(A,[e])]) -> [(A, [e])] {
  lhs ||| rhs |+| lhs |^| rhs
}

public func|*|<A:Numeric> (_ lhs:[(A,e)], _ rhs:[[(A,[e])]]) -> [(A, [e])] {
  reduce(with: |*|, zip2(with: |*|)(lhs, rhs))
}

public func |*|<A:Numeric> (_ lhs:A, _ rhs:(A, [e])) -> [(A, [e])] {
  lhs ||| rhs |+| lhs |^| rhs
}

public func |*|<A:Numeric> (_ lhs:(A, [e]), _ rhs:A) -> [(A, [e])] {
  lhs ||| rhs |+| lhs |^| rhs
}
