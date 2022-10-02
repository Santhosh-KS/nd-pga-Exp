import Foundation

precedencegroup AdditionEvaluation {
  associativity:left
  lowerThan:AdditionPrecedence, MultiplicationPrecedence
}

infix operator |+|:AdditionEvaluation

public func |+|<A:Numeric> (_ lhs:A, _ rhs:A)  -> A {
  lhs+rhs
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:[A])  -> A {
  zip2(with: |+|)(lhs, rhs).reduce(0, |+|)
}

public func |+|<A:Numeric> (_ lhs:A, _ rhs:e)  -> [(A,[e])] {
  [(lhs, []), (rhs |> unit >>> arrayfySecond)]
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:A)  -> [(A,[e])] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:e)  -> [(A,[e])] {
  [(lhs.reduce(0, |+|), []), (rhs |> unit >>> arrayfySecond)]
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:[A])  -> [(A,[e])] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:e)  -> [(A,e)] {
  (lhs |> unit) |+| (rhs |> unit)
}

public func |+|<A:Numeric> (_ lhs:(A, e), _ rhs:(A, e))  -> [(A,e)] {
  if isEqualBasis(lhs.1, rhs.1) {
    return [(lhs.0 |+| rhs.0, lhs.1)]
  }
  return [lhs, rhs]
}

public func |+|<A:Numeric> (_ lhs:[e], _ rhs:[e]) -> [(A,[e])] {
  (lhs |> unit) |+| (rhs |> unit)
}

public func |+|<A:Numeric> (_ lhs:[e], _ rhs:e) -> [(A,[e])] {
  lhs |+| (rhs |> arrayfy)
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:[e]) -> [(A,[e])] {
  (lhs |> arrayfy) |+| rhs
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:(A, [e]))  -> [(A,[e])] {
  if lhs.0 == 0 && rhs.0 == 0 { return [] }
  if lhs.0 == 0 { return [rhs] }
  if rhs.0 == 0 { return [lhs] }
  if lhs.1.sorted() == rhs.1.sorted() {
    let le = lhs |> normalized
    let re = rhs |> normalized
    return [(le.0 + re.0, lhs.1.sorted())]
  }
  return [lhs, rhs].sorted { pair1, pair2 in
    pair1.1.count < pair2.1.count
  }
}

public func |+|<A:Numeric> (_ lhs:[(A, e)], _ rhs:[(A, e)])  -> [(A,[e])] {
  (lhs |> arrayfy) |+| (rhs |> arrayfy)
}

public func |+|<A:Numeric> (_ lhs:[(A, [e])], _ rhs:[(A, [e])])  -> [(A,[e])] {
  return reduce(with: |+|, (lhs |> filter) + (rhs |> filter))
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:(A, e))  -> [(A,[e])] {
  lhs |+| (rhs |> arrayfySecond)
}

public func |+|<A:Numeric> (_ lhs:(A, e), _ rhs:(A, [e]))  -> [(A,[e])] {
  (lhs |> arrayfySecond) |+| rhs
}

public func |+|<A:Numeric> (_ lhs:[(A, e)], _ rhs:(A, e))  -> [(A,[e])] {
  lhs.map(arrayfySecond) |+| (rhs |> arrayfySecond >>> arrayfy)
}

public func |+|<A:Numeric> (_ lhs:(A, e), _ rhs:[(A, e)])  -> [(A,[e])] {
  (lhs |> arrayfySecond >>> arrayfy)  |+| rhs.map(arrayfySecond)
}

public func |+|<A:Numeric> (_ lhs:[(A, [e])], _ rhs:(A, e))  -> [(A,[e])] {
  lhs |+| (rhs |> arrayfySecond >>> arrayfy)
}

public func |+|<A:Numeric> (_ lhs:(A, e), _ rhs: [(A, [e])])  -> [(A,[e])] {
  (lhs |> arrayfySecond >>> arrayfy) |+| rhs
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:e)  -> [(A,[e])] {
  lhs |+| (rhs |> unit >>> arrayfySecond)
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:(A, [e]))  -> [(A,[e])] {
  (lhs |> unit >>> arrayfySecond) |+| rhs
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:[e])  -> [(A,[e])] {
  lhs |+| (rhs |> unit)
}

public func |+|<A:Numeric> (_ lhs:[e], _ rhs:(A, [e]))  -> [(A,[e])] {
  (lhs |> unit) |+| rhs
}

public func |+|<A:Numeric> (_ lhs:[(A, e)], _ rhs:(A, [e]))  -> [(A,[e])] {
  lhs.map(arrayfySecond) |+| (rhs |> arrayfy)
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:[(A, e)])  -> [(A,[e])] {
  (lhs |> arrayfy) |+| rhs.map(arrayfySecond)
}

public func |+|<A:Numeric> (_ lhs:[(A, [e])], _ rhs:(A, [e]))  -> [(A,[e])] {
  lhs |+| (rhs |> arrayfy)
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:[(A, [e])])  -> [(A,[e])] {
  (lhs |> arrayfy) |+| rhs
}
