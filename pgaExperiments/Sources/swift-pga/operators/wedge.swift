import Foundation


  // a  *  b = a . b + a ^ b -- (1)
  // a |*| b = a|||b + a|^|b --> Notation Convention equivalent of eq(1)

  // a = a_x*e(1) + a_y*e(2) + a_z*e(3) --> (a_x, e(1)) + (a_y, e(2)) + (a_z, e(3))
  // b = b_x*e(1) + b_y*e(2) + b_z*e(3) --> (b_x, e(1)) + (b_y, e(2)) + (b_z, e(3))

  // a |^| b = (a_x*e(1) + a_y*e(2) + a_z*e(3)) |^| (b_x*e(1) + b_y*e(2) + b_z*e(3))
  //         = 0 + a_y*b_x e(2)^e(1) + a_z*b_x e(3)^e(1)
  //             + a_x*b_y e(1)^e(2) +         0         + a_z*b_y e(3)^e(2)
  //                                 + a_x*b_z e(1)^e(3) + a_y*b_z e(2)^e(3) + 0
  //         = 0 - a_y*b_x e(1)^e(2) - a_z*b_x e(1)^e(3)
  //             + a_x*b_y e(1)^e(2) +         0         - a_z*b_y e(2)^e(3)
  //                                 + a_x*b_z e(1)^e(3) + a_y*b_z e(2)^e(3) + 0
  //         = (a_x*b_y - a_y*b_x)*e(1)^e(2) +
  //           (a_x*b_z - a_z*b_x)*e(1)^e(3) +
  //           (a_y*b_z - a_z*b_y)*e(2) e(3)

infix operator |^|:multiplicationProcessingOrder

public func |^|<A:Numeric> (_ lhs:A, _ rhs:A) -> A {
  return (lhs * rhs) * (0.5 as! A)
}

func |^|<A:Numeric>(_ lhs:[A], _ rhs:[A]) -> A {
  lhs.reduce(1, |^|) ||| rhs.reduce(1, |^|)
}

func |^|(_ lhs:e, _ rhs:e) -> [e] {
  if lhs == rhs { return [] }
  return [lhs, rhs]
}

func |^|(_ lhs:[e], _ rhs:[e]) -> [[e]] {
    //  zip2(with: |^|)(lhs, rhs) |> compactMap
    // (a+b)^(a+b) = a^a + b^a + a^b + b^b = 0
    // a^a = 0 and b^b = 0,
    // a^b = -b^a
  var retVal = [[e]]()

  lhs.forEach { le in
    rhs.forEach { re in
      retVal.append(le |^| re)
    }
  }
  return retVal |> compactMap
}

func |^|<A:Numeric> (_ lhs:A, rhs:e) -> e {
  rhs
}

func |^|<A:Numeric> (_ lhs:[A], rhs:[e]) -> [e] {
  zip2(with: |^|)(lhs, rhs)
}

func |^|<A:Numeric> (_ lhs:e, rhs:A) -> e {
  lhs
}

func |^|<A:Numeric> (_ lhs:[e], rhs:[A]) -> [e] {
  zip2(with: |^|)(rhs, lhs)
}
//public func |^|<A:Numeric>(_ lhs:[A], _ rhs:[e]) -> (A, [e]) {
//  (lhs.reduce(1, |+|), rhs)
//}

//public func |^|<A:Numeric>(_ lhs:[[A]], _ rhs:[[e]]) -> [(A, [e])] {
//  zip2(with: |^|)(lhs, rhs)
//}

//public func |^|<A:Numeric>(_ lhs:[e], _ rhs:[A]) -> (A, [e]) {
//  rhs |^| lhs
//}
//
//public func |^|<A:Numeric>(_ lhs:[[e]], _ rhs:[[A]]) -> [(A, [e])] {
//  rhs |^| lhs
//}

  //(ta)^b = a^(tb) = t(a^b) // Scalar factorization for the wedge product.
func |^|<A:Numeric> (_ lhs:A, _ rhs:(A, e)) -> (A, e) {
  if lhs == A.zero || rhs.0 == A.zero{
    return (A.zero, e(0))
  }
  return (lhs*rhs.0, rhs.1)
}

func |^|<A:Numeric> (_ lhs:[A], _ rhs:[(A, e)]) -> [(A, e)] {
  zip2(with: |^|)(lhs, rhs) |> reduce
}

func |^|<A:Numeric> (_ lhs:(A, e), _ rhs:A) -> (A, e) {
  rhs |^| lhs
}

func |^|<A:Numeric> (_ lhs:[(A, e)], _ rhs:[A]) -> [(A, e)] {
  rhs |^| lhs
}



func |^|(_ lhs:[e], rhs:e) -> [e] {
  if lhs.contains(where: { $0 == rhs }) {
    return []
  }
  var retVal = [e]()
  retVal.append(contentsOf: lhs)
  retVal.append(rhs)
  return retVal
}

func |^|(_ lhs:e, rhs:[e]) -> [e] {
  if rhs.contains(where: { $0 == lhs }) {
    return []
  }
  var retVal = [e]()
  retVal.append(lhs)
  retVal.append(contentsOf: rhs)
  return retVal
}

func |^|<A:Numeric> (_ lhs:e, _ rhs:(A, e)) -> (A, [e]) {
  if lhs == rhs.1 {
    return wedge0()
  }
  return (rhs.0, [lhs, rhs.1])
}

func |^|<A:Numeric> (_ lhs:[e], _ rhs:[(A, e)]) -> [(A, [e])] {
  zip2(with: |^|)(lhs, rhs) |> compactMap
}

func |^|<A:Numeric> (_ lhs:(A, e), _ rhs:e) -> (A, [e]) {
  if lhs.1 == rhs || lhs.0 == A.zero {
    return wedge0()
  }
  return (lhs.0, [lhs.1, rhs])
}

func |^|<A:Numeric> (_ lhs:[(A, e)], _ rhs:[e]) -> [(A, [e])] {
    //  zip2(with: |^|)(lhs, rhs) |> reduce
  var retVal = [(A, [e])]()
  
  lhs.forEach { pairs in
    rhs.forEach { re in
      retVal.append((pairs.0, pairs.1 |^| re))
    }
  }
  return retVal |> compactMap
}



func |^|<A:Numeric> (_ lhs:(A, e), _ rhs:(A, e)) -> (A, [e]) {
  if lhs.1 == rhs.1 || lhs.0 == A.zero || rhs.0 == A.zero {
    return wedge0()
  }
  return (lhs.0*rhs.0, [lhs.1, rhs.1])
}

func |^|<A:Numeric> (_ lhs:[(A, e)], _ rhs:[(A, e)]) -> [(A, [e])] {
  var retVal = [(A, [e])]()
  lhs.forEach { le in
    rhs.forEach { re in
      retVal.append(le |^| re)
    }
  }
  return retVal |> compactMap
}

func |^|<A:Numeric> (_ lhs:(A,[e]), _ rhs:(A,[e])) -> (A,[[e]]) {
  if lhs.0 == A.zero || rhs.0 == A.zero {
    return (A.zero, [[]])
  }
  return (lhs.0*rhs.0, lhs.1 |^| rhs.1)
}

// 10e(1) |^| (2e(2)^3e(3)) = 10e(1) |^| (6(e(2)^e(3))) = 60((e(1)^e(2)^e(3)))
func |^|<A:Numeric> (_ lhs:(A, e), _ rhs:(A, [e])) -> (A, [e]) {
  if lhs.0 == A.zero || rhs.0 == A.zero {
    return wedge0()
  }
  return (lhs.0*rhs.0, lhs.1 |^| rhs.1)
}

func |^|<A:Numeric> (_ lhs:[(A, e)], _ rhs:[(A, [e])]) -> [(A, [e])] {
  zip2(with: |^|)(lhs,rhs) |> compactMap
}

func |^|<A:Numeric> (_ lhs:(A, [e]), _ rhs:(A, e)) -> (A, [e]) {
  if lhs.0 == A.zero || rhs.0 == A.zero {
    return wedge0()
  }
  return (lhs.0*rhs.0, lhs.1 |^| rhs.1)
}

func |^|<A:Numeric> (_ lhs:[(A, [e])], _ rhs:[(A, e)]) -> [(A, [e])] {
  zip2(with: |^|)(lhs,rhs) |> compactMap
}

func |^|<A:Numeric> (_ lhs:(A, [e]), _ rhs:e) -> (A, [e]) {
  if lhs.0 == A.zero {
    return wedge0()
  }
  return (lhs.0, lhs.1 |^| rhs)
}

func |^|<A:Numeric> (_ lhs:[(A, [e])], _ rhs:[e]) -> [(A, [e])] {
  zip2(with: |^|)(lhs,rhs) |> compactMap
}

public func |^|<A:Numeric> (_ lhs:e, _ rhs:(A, [e])) -> (A, [e]) {
  if rhs.0 == A.zero {
    return wedge0()
  }
  return (rhs.0, lhs |^| rhs.1)
}

public func |^|<A:Numeric> (_ lhs:[e], _ rhs:[(A, [e])]) -> [(A, [e])] {
  zip2(with: |^|)(lhs,rhs) |> compactMap
}


  //https://www.euclideanspace.com/maths/algebra/vectors/related/bivector/index.htm
  // (a+b)^(a+b) = a^a + b^a + a^b + b^b = 0
  // a^a = 0 and b^b = 0,
  // a^b = -b^a

  // (a+b+c)^(a+b+c)^(a+b+c)


