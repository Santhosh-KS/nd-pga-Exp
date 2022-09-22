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

public func |+|<A:Numeric> (_ lhs:e, _ rhs:e)  -> [(A,e)] {
  (1, lhs) |+| (1, rhs)
}

public func |+|<A:Numeric> (_ lhs:(A, e), _ rhs:(A, e))  -> [(A,e)] {
  if isEqualBasis(lhs.1, rhs.1) {
    return [(lhs.0 |+| rhs.0, lhs.1)]
  }
  return [lhs, rhs]
}

public func |+|<A:Numeric> (_ lhs:[e], _ rhs:[e]) -> [(A,[e])] {
  (1, lhs) |+| (1, rhs)
}

public func |+|<A:Numeric> (_ lhs:[e], _ rhs:e) -> [(A,[e])] {
  lhs |+| [rhs]
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:[e]) -> [(A,[e])] {
  [lhs] |+| rhs
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:(A, [e]))  -> [(A,[e])] {
  if lhs.0 == 0 && rhs.0 == 0 { return [] }
  if lhs.0 == 0 { return [rhs] }
  if rhs.0 == 0 { return [lhs] }
  if lhs.1.sorted() == rhs.1.sorted() {
    let le = normalized(lhs)
    let re = normalized(rhs)
    return [(le.0 + re.0, lhs.1.sorted())]
  }
  return [lhs, rhs].sorted { pair1, pair2 in
     pair1.1.count < pair2.1.count
  }
}

public func |+|<A:Numeric> (_ lhs:[(A, [e])], _ rhs:[(A, [e])])  -> [(A,[e])] {
  reduce(with: |+|, lhs + rhs)
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:(A, e))  -> [(A,[e])] {
  lhs |+| (rhs.0, [rhs.1])
}

public func |+|<A:Numeric> (_ lhs:(A, e), _ rhs:(A, [e]))  -> [(A,[e])] {
  (lhs.0, [lhs.1]) |+| rhs
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:e)  -> [(A,[e])] {
  lhs |+| (1, [rhs])
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:(A, [e]))  -> [(A,[e])] {
  (1, [lhs]) |+| rhs
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:[e])  -> [(A,[e])] {
  lhs |+| (1, rhs)
}

public func |+|<A:Numeric> (_ lhs:[e], _ rhs:(A, [e]))  -> [(A,[e])] {
  (1, lhs) |+| rhs
}

// [(A, e)] |+| (A, [e])
public func |+|<A:Numeric> (_ lhs:[(A, e)], _ rhs:(A, [e]))  -> [(A,[e])] {
  lhs.map { pairs in (pairs.0, [pairs.1]) } |+| [rhs]
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:[(A, e)])  -> [(A,[e])] {
  [lhs] |+| rhs.map { pairs in (pairs.0, [pairs.1]) }
}

  // [(A,[e])], (A, [e])
public func |+|<A:Numeric> (_ lhs:[(A, [e])], _ rhs:(A, [e]))  -> [(A,[e])] {
  lhs |+| [rhs]
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:[(A, [e])])  -> [(A,[e])] {
  [lhs] |+| rhs
}
