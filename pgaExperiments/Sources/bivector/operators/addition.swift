import Foundation

precedencegroup AdditionEvaluation {
  associativity:left
  lowerThan:AdditionPrecedence, MultiplicationPrecedence
  higherThan:ForwardApplication
}

infix operator |+|:AdditionEvaluation

public func |+|<A:Numeric> (_ lhs:A, _ rhs:A)  -> A {
  lhs+rhs
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:[A])  -> A {
  zip2(with: |+|)(lhs, rhs).reduce(0, |+|)
}

public func |+|<A:Numeric> (_ lhs:A, _ rhs:e)  -> [(A,[e])] {
  [(lhs,[]), (1, [rhs])]
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:A)  -> [(A,[e])] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:e)  -> [(A,[e])] {
  [(lhs.reduce(0, |+|), []), (1, [rhs])]
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:[A])  -> [(A,[e])] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:e)  -> [(A,[e])] {
  if isEqualBasis(lhs, rhs) {
    return [(2, [lhs,rhs])].map(normalized)
  }
  return [ (1,[lhs]), (1,[rhs]) ].map(normalized)
}
