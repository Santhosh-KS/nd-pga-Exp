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
  zip2(with: |+|)(lhs, rhs).reduce(0, |+|)
}

public func |+|<A:Numeric> (_ lhs:A, _ rhs:e)  -> [(A, e)] {
  if rhs.index == 0 {
    return [(lhs,rhs)]
  }
  return [(lhs,e0), (1, rhs)]
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:[e]) -> [(A,e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:A)  -> [(A, e)] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:[e], _ rhs:[A])  -> [(A, e)] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:e)  -> [(A, e)] {
  [(1,lhs), (1,rhs)]
}

public func |+|<A:Numeric> (_ lhs:[e], _ rhs:[e])  -> [(A, e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+|<A:Numeric> (_ lhs:A, _ rhs:(A, e)) -> [(A, e)] {
  if rhs.1.index == 0  {
    return [(lhs+rhs.0, e0)]
  }
  return [(lhs, e0), rhs]
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:[(A, e)]) -> [(A, e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+|<A:Numeric> (_ lhs:(A, e), _ rhs:A) -> [(A, e)] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:[(A, e)], _ rhs:[A]) -> [(A, e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+|<A:Numeric> (_ lhs:(A,e), _ rhs:(A,e)) -> [(A,e)] {
  if lhs.1 == rhs.1 {
    return [(lhs.0+rhs.0, lhs.1)]
  }
//  return [lhs, rhs].sorted(by: <)
  return [lhs, rhs]
}

public func |+|<A:Numeric> (_ lhs:[(A,e)], _ rhs:[(A,e)])  -> [(A, e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+|<A:Numeric> (_ lhs:A, _ rhs:[(A,e)]) -> [(A,e)] {
  rhs.map { (first:A, second:e) -> (A,e) in
    if second.index == 0 {
      return (first+lhs, second)
    }
    return (first, second)
  }
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:[[(A,e)]]) -> [(A,e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+|<A:Numeric> (_ lhs:[(A,e)], _ rhs:A) -> [(A,e)] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:[[(A,e)]], _ rhs:[A]) -> [(A,e)] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:[(A,e)], _ rhs:(A,e)) -> [(A,e)] {
  lhs.map { (first:A, second:e) -> (A, e) in
    if second == rhs.1 {
      return (first+rhs.0, second)
    }
    return (first,second)
  }
}

public func |+|<A:Numeric> (_ lhs:(A,e), _ rhs:[(A,e)]) -> [(A,e)] {
  rhs |+| lhs
}

public func |+|<A:Numeric>(_ lhs:[[(A,e)]], _ rhs:[(A,e)]) -> [(A,e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

// 10e(1) |+| (2e(2)^3e(3) = 10(e(1)^e(0)) |+| (6(e(2)^e(3)))
// [(10,[e(1),e(0)]), (6(e(2)^e(3)))]
public func |+|<A:Numeric> (_ lhs:(A, e), _ rhs:(A,[e])) -> [(A,[e])] {
  [(lhs.0,[lhs.1]), rhs]
}

public func |+|<A:Numeric> (_ lhs:[(A, e)], _ rhs:[(A,[e])]) -> [(A,[e])] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:(A,e)) -> [(A,[e])] {
   rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:[(A, [e])], _ rhs:[(A,e)]) -> [(A,[e])] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+|<A:Numeric> (_ lhs:(A, [e]), _ rhs:(A,[e])) -> [(A,[e])] {
  if lhs.1 == rhs.1 {
    return [ ((lhs.0 + rhs.0), lhs.1)]
  }
  return [lhs, rhs]
}

public func |+|<A:Numeric> (_ lhs:[(A, [e])], _ rhs:[(A,[e])]) -> [(A,[e])] {
  zip2(with: |+|)(lhs,rhs) |> flatmap
}

