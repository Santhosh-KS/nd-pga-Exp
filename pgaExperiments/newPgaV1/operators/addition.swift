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
//  zip2(with: |+|)(lhs, rhs).reduce(A.zero, |+|)
  lhs.reduce(A.zero, |+|) |+| rhs.reduce(A.zero, |+|)
}

public func |+|<A:Numeric> (_ lhs:A, _ rhs:e)  -> (A, e) {
  return (lhs, rhs)
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:[e])  -> [(A, e)] {
  reduce(with: |+|, zip2(with: |+|)(lhs, rhs))
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:A)  -> (A, e) {
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
  reduce(with: |+|, zip2(with: |+|)(lhs, rhs) |> flatmap)
}

public func |+|<A:Numeric> (_ lhs:e, _ rhs:(A, e))  -> [(A, e)] {
  if lhs == rhs.1 {
    return [rhs.0 + 1] |+| [rhs.1]
  }
  return [A.zero + 1, rhs.0] |+| [lhs, rhs.1]
}

public func |+|<A:Numeric> (_ lhs:(A, e), _ rhs:e)  -> [(A, e)] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:[(A,e)], _ rhs:(A,e)) -> [(A,e)] {
  var retVal:[(A,e)] = []
  let _ = zip(0..., lhs).forEach { nestedPairs in
    let index = nestedPairs.0
    let pairs = nestedPairs.1
    if retVal.contains(where: { $0.1 == pairs.1 }) {
      retVal[index].0 += rhs.0
    } else {
      retVal.append(pairs)
    }
  }
  return reduce(with: |+|, retVal)
}


public func |+|<A:Numeric> (_ lhs:(A,e), _ rhs:(A,e)) -> [(A, e)] {
  return [lhs.0, rhs.0] |+| [lhs.1, rhs.1]
}

public func |+|<A:Numeric> (_ lhs:[(A,e)], _ rhs:[(A,e)]) -> [(A, e)] {
  reduce(with: |+|, zip2(with: |+|)(lhs, rhs) |> flatmap)
}

public func |+|<A:Numeric> (_ lhs:([A], [e]), _ rhs: (A,e)) -> [(A, e)] {
  (lhs.0 |+| lhs.1) |+| rhs
}

public func |+|<A:Numeric> (_ lhs:(A,e), _ rhs: ([A], [e]) ) -> [(A, e)] {
  rhs |+| lhs
}

public func |+|<A:Numeric> (_ lhs:A, _ rhs:(A,e)) -> [(A,e)] {
  (lhs, e(0)) |+| rhs
}

public func |+|<A:Numeric> (_ lhs:(A,e), _ rhs:A) -> [(A,e)] {
  lhs |+| (rhs, e(0))
}

public func |+|<A:Numeric> (_ lhs:[A], _ rhs:[(A,e)]) -> [(A,e)] {
  reduce(with: |+|, zip2(with: |+|)(lhs, rhs) |> flatmap)
}

public func |+|<A:Numeric> (_ lhs:[(A,e)], _ rhs:[A]) -> [(A,e)] {
  reduce(with: |+|, zip2(with: |+|)(lhs, rhs) |> flatmap)
}

public func |+|<A:Numeric>(_ lhs:(A,e), _ rhs:[(A,e)]) -> [(A,e)] {
  var retVal:[(A,e)] = []
  retVal.append(lhs)
  retVal.append(contentsOf: rhs)
  return reduce(with: |+|, retVal)
}

