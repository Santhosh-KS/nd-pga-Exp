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
  [(lhs, []), rhs]
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


// (A, [e])
// TODO Ignore not validated
//public func |+|<A:Numeric> (_ lhs:e, _ rhs:(A, e))  -> [(A, e)] {
//  if lhs == rhs.1 {
//    return [(rhs.0 + (A.zero + 1) , rhs.1)]
//  }
//  return [(A.zero + 1 , lhs), rhs]
//}
//
//public func |+|<A:Numeric> (_ lhs:(A, e), _ rhs:e)  -> [(A, e)] {
//  rhs |+| lhs
//}
//
//public func |+|<A:Numeric> (_ lhs:[(A,e)], _ rhs:(A,e)) -> [(A,e)] {
//  var retVal:[(A,e)] = []
//  var notfound = true
//  let _ = zip(0..., lhs).forEach { nestedPairs in
//    let index = nestedPairs.0
//    let pairs = nestedPairs.1
//    if retVal.contains(where: { $0.1 == pairs.1 }) {
//      retVal[index].0 += rhs.0
//      notfound = false
//    } else {
//      retVal.append(pairs)
//    }
//  }
//  if notfound {
//    retVal.append(rhs)
//  }
//  return reduce(with: |+|, retVal)
//}
//
//
//public func |+|<A:Numeric> (_ lhs:(A,e), _ rhs:(A,e)) -> [(A, e)] {
//  return [lhs.0, rhs.0] |+| [lhs.1, rhs.1]
//}
//
//public func |+|<A:Numeric> (_ lhs:[(A,e)], _ rhs:[(A,e)]) -> [(A, e)] {
//  reduce(with: |+|, zip2(with: |+|)(lhs, rhs) |> flatmap)
//}
//
//public func |+|<A:Numeric> (_ lhs:([A], [e]), _ rhs: (A,e)) -> [(A, e)] {
//  (lhs.0 |+| lhs.1) |+| rhs
//}
//
//public func |+|<A:Numeric> (_ lhs:(A,e), _ rhs: ([A], [e]) ) -> [(A, e)] {
//  rhs |+| lhs
//}
//
//
//
//public func |+|<A:Numeric> (_ lhs:(A,e), _ rhs:A) -> [(A,e)] {
//  lhs |+| (rhs, e(0))
//}
//
//public func |+|<A:Numeric> (_ lhs:[A], _ rhs:[(A,e)]) -> [(A,e)] {
//  reduce(with: |+|, zip2(with: |+|)(lhs, rhs) |> flatmap)
//}
//
//public func |+|<A:Numeric> (_ lhs:[(A,e)], _ rhs:[A]) -> [(A,e)] {
//  reduce(with: |+|, zip2(with: |+|)(lhs, rhs) |> flatmap)
//}
//
//public func |+|<A:Numeric>(_ lhs:(A,e), _ rhs:[(A,e)]) -> [(A,e)] {
//  var retVal:[(A,e)] = []
//  retVal.append(lhs)
//  retVal.append(contentsOf: rhs)
//  return reduce(with: |+|, retVal)
//}
//
// TODO: Add tests to below function overloads
//
//public func |+|<A:Numeric>(_ lhs:(A, [e]), _ rhs:A) -> [(A,[e])] {
//  var retVal:[(A,[e])] = []
//  retVal.append(lhs)
//  retVal.append((rhs,[e(0)]))
//  return retVal
//}
//
//public func |+|<A:Numeric>(_ lhs:[(A, [e])], _ rhs:[A]) -> [[(A,[e])]] {
//  zip2(with: |+|)(lhs, rhs)
//}
//
//public func |+|<A:Numeric>(_ lhs:A, _ rhs:(A, [e])) -> [(A,[e])] {
//  rhs |+| lhs
//}
//
//public func |+|<A:Numeric>(_ lhs:[A], _ rhs:[(A, [e])]) -> [[(A,[e])]] {
//  rhs |+| lhs
//}
//
//public func |+|<A:Numeric>(_ lhs:(A, [e]), _ rhs:(A, e)) -> [(A,[e])] {
//  if lhs.1.isEmpty {
//    return [(lhs.0, []), (rhs.0, [rhs.1])]
//  }
//  return [lhs, (rhs.0, [rhs.1])]
//}
//
//public func |+|<A:Numeric>(_ lhs:[(A, [e])], _ rhs:[(A, e)]) -> [[(A,[e])]] {
//  zip2(with: |+|)(lhs, rhs)
//}
//
//public func |+|<A:Numeric>(_ lhs:(A, e), _ rhs: (A, [e])) -> [(A,[e])] {
//  rhs |+| lhs
//}
//
//public func |+|<A:Numeric>(_ lhs:[(A, e)], _ rhs: [(A, [e])]) -> [[(A,[e])]] {
//  rhs |+| lhs
//}
//
//public func |+|<A:Numeric>(_ lhs:(A, [e]), _ rhs: (A, [e])) -> [(A,[e])] {
//  if lhs.1.count == rhs.1.count && lhs.1 == rhs.1 {
//    return [(lhs.0 + rhs.0, lhs.1)]
//  }
//  return [lhs, rhs]
//}
//
//public func|+|<A:Numeric>(_ lhs:A, _ rhs:[[e]]) {
//  
//}
//
//
//
