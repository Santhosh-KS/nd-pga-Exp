import Foundation

precedencegroup additionEvaluation {
  associativity:left
  lowerThan:AdditionPrecedence, MultiplicationPrecedence
}

infix operator |+|:additionEvaluation

public func |+|<A:Numeric> (_ lhs:A, _ rhs:A)  -> A {
  lhs+rhs
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:[A])  -> A {
  zip2(with: |+|)(lhs, rhs).reduce(A.zero, |+|)
}

public func |+|<A:Numeric> (_ lhs:A, _ rhs:e)  -> [(A, e)] {
  if lhs == A.zero {
    return [(A.zero + 1, rhs)]
  }
  return [(lhs, e(0)), (A.zero + 1, rhs)]
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:[e])  -> [(A, e)] {
   reduce(with: |+|, zip2(with: |+|)(lhs,rhs))
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:A)  -> [(A, e)] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:[e], _ rhs:[A])  -> [(A, e)] {
  reduce(with: |+|, zip2(with: |+|)(lhs, rhs))
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:e)  -> [(A, e)] {
  if lhs == rhs {
    return [A.zero + 2] |+| [lhs]
  }
  return [A.zero + 1, A.zero + 1] |+| [lhs, rhs]
}

public func |+|<A:Numeric> (_ lhs:[e], _ rhs:[e])  -> [(A, e)] {
  reduce(with: |+|, zip2(with: |+|)(lhs, rhs))
}

public func |+|<A:Numeric> (_ lhs:A, _ rhs:[e])  -> (A, [e]) {
  (lhs, rhs)
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:[[e]])  -> [(A, [e])] {
  reduce(with: |+|, zip2(with: |+|)(lhs,rhs))
}

public func |+|<A:Numeric> (_ lhs:[e], _ rhs:A)  -> (A, [e]) {
  (rhs, lhs)
}

public func |+|<A:Numeric> (_ lhs:[[e]], _ rhs:[A])  -> [(A, [e])] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:(A, [e]))  -> [(A, [e])] {
  var retVal = [(A, [e])]()
  retVal.append((A.zero + 1, [lhs]))
  retVal.append(rhs)
  return retVal
}

public func |+|<A:Numeric> (_ lhs:[e], _ rhs:[(A, [e])])  -> [(A, [e])] {
  reduce(with: |+|, zip2(with: |+|)(lhs, rhs))
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:e)  -> [(A, [e])] {
  var retVal = [(A, [e])]()
  retVal.append(lhs)
  retVal.append((A.zero + 1, [rhs]))
  return retVal
}

public func |+|<A:Numeric> (_ lhs:[(A, [e])], _ rhs:[e])  -> [(A, [e])] {
  reduce(with: |+|, zip2(with: |+|)(lhs, rhs))
}

public func |+|<A:Numeric> (_ lhs:A, _ rhs:(A,[e])) -> [(A, [e])] {
  if lhs == 0 { return [ rhs ]}
  return [(lhs, [e(0)]), rhs]
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:[(A,[e])]) -> [(A, [e])] {
  reduce(with: |+|, zip2(with: |+|)(lhs, rhs))
}

public func |+|<A:Numeric> (_ lhs:(A,[e]), _ rhs:A) -> [(A, [e])] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:[(A,[e])], _ rhs:[A]) -> [(A, [e])] {
  reduce(with: |+|, zip2(with: |+|)(lhs, rhs))
}

public func |+|<A:Numeric> (_ lhs:A, _ rhs:(A,e)) -> [(A,e)] {
  if lhs != 0  { return [(lhs, e(0)), rhs] }
  return [rhs]
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:[(A,e)]) -> [(A,e)] {
  reduce(with: |+|, zip2(with: |+|)(lhs, rhs))
}

//A and (A, [e])
public func |+|<A:Numeric> (_ lhs:A , _ rhs:[(A,[e])]) -> [(A,[e])] {
  var retVal = [(A,[e])]()
  if lhs != 0 { retVal.append((lhs,[])) }
  retVal.append(contentsOf: rhs)
  return retVal
}

// [(A,e)], (A,e)

public func |+|<A:Numeric> (_ lhs:[(A,e)], _ rhs:(A,e)) -> [(A,e)] {
  var retVal = [(A,e)]()
  retVal.append(contentsOf: lhs)
  retVal.append(rhs)
  return reduce(with: |+|, retVal)
}

public func |+|<A:Numeric> (_ lhs:(A,e), _ rhs:[(A,e)]) -> [(A,e)] {
  var retVal = [(A,e)]()
  retVal.append(lhs)
  retVal.append(contentsOf: rhs)
  return reduce(with: |+|, retVal)
}

public func |+|<A:Numeric> (_ lhs:(A,e), _ rhs:(A,e)) -> [(A,e)] {
  return reduce(with: |+|, [lhs, rhs])
}

