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

//s ^ t = t ^ s = st  // Wedge product between scalars.
public func |^|<A:Numeric> (_ lhs:A, _ rhs:A) -> A {
  lhs*rhs
}

public func |^|<A:Numeric> (_ lhs:[A], _ rhs:[A]) -> A {
  zip2(with: |^|)(lhs, rhs).reduce(1, |^|)
}

//(ta)^b = a^(tb) = t(a^b) // Scalar factorization for the wedge product.
public func |^|<A:Numeric> (_ lhs:A, _ rhs:(A, e)) -> (A, e) {
  if lhs == 0 || rhs.0 == 0 {
    return (0, e0)
  }
  return (lhs*rhs.0, rhs.1)
}

public func |^|<A:Numeric> (_ lhs:[A], _ rhs:[(A, e)]) -> [(A, e)] {
  zip2(with: |^|)(lhs, rhs) |> reduce
}

public func |^|<A:Numeric> (_ lhs:(A, e), _ rhs:A) -> (A, e) {
  rhs |^| lhs
}

public func |^|<A:Numeric> (_ lhs:[(A, e)], _ rhs:[A]) -> [(A, e)] {
  rhs |^| lhs
}

public func |^|<A:Numeric> (_ lhs:A, rhs:e) -> (A, e) {
  return (lhs, rhs)
}

public func |^|<A:Numeric> (_ lhs:[A], rhs:[e]) -> [(A, e)] {
 zip2(with: |^|)(lhs, rhs) |> reduce
}

public func |^|<A:Numeric> (_ lhs:e, rhs:A) -> (A, e) {
  rhs |^| lhs
}

public func |^|<A:Numeric> (_ lhs:[e], rhs:[A]) -> [(A, e)] {
  rhs |^| lhs
}

public func |^|<A:Numeric> (_ lhs:e, _ rhs:(A, e)) -> (A, [e]) {
  if lhs == rhs.1 {
    return wedge0()
  }
  return (rhs.0, [lhs, rhs.1])
}

public func |^|<A:Numeric> (_ lhs:[e], _ rhs:[(A, e)]) -> [(A, [e])] {
  zip2(with: |^|)(lhs, rhs) |> reduce
}

public func |^|<A:Numeric> (_ lhs:(A, e), _ rhs:e) -> (A, [e]) {
  if lhs.1 == rhs {
    return wedge0()
  }
  return (lhs.0, [lhs.1, rhs])
}

public func |^|<A:Numeric> (_ lhs:[(A, e)], _ rhs:[e]) -> [(A, [e])] {
  zip2(with: |^|)(lhs, rhs) |> reduce
}

public func |^|(_ lhs:e, _ rhs:e) -> [e] {
  if lhs == rhs {
    return []
  }
  return [lhs, rhs]
}

public func |^|(_ lhs:[e], _ rhs:[e]) -> [[e]] {
  zip2(with: |^|)(lhs, rhs) |> compactMap
}

public func |^|<A:Numeric> (_ lhs:(A, e), _ rhs:(A, e)) -> (A, [e]) {
  if lhs.1 == rhs.1 || lhs.0 == A.zero || rhs.0 == A.zero {
    return wedge0()
  }
  return (lhs.0*rhs.0, [lhs.1, rhs.1])
}

public func |^|<A:Numeric> (_ lhs:[(A, e)], _ rhs:[(A, e)]) -> [(A, [e])] {
  if lhs.count == rhs.count {
    return zip2(with: |^|)(lhs, rhs) |> reduce
  }
  else {
      // TODO: Not clear how to handle the uequal lenght of multivectors.
      // will kick this can down the road, when actual problem is encountered.
    fatalError("Not implemented yet!")
  }
}

// (10, e(1)^e(2)) |^| (5, e(1))
public func |^|<A:Numeric> (_ lhs:(A,[e]), _ rhs:(A,[e])) -> (A,[e]) {
  if lhs.1.count == rhs.1.count {
    if lhs.1 == rhs.1 || lhs.0 == A.zero || rhs.0 == A.zero {
      return wedge0()
    } else {
        var es = [e]()
      var foundDuplicate = false
      lhs.1.forEach { le in
        if !rhs.1.contains(where: { $0 == le }) {
          es.append(le)
        } else {
          foundDuplicate = true
        }
      }
      if foundDuplicate {
        return (A.zero, [])
      } else {
        es.append(contentsOf: rhs.1)
        return (lhs.0 * rhs.0, es)
      }
    }
  } else {
    // TODO: Not clear how to handle the uequal lenght of multivectors.
    // will kick this can down the road, when actual problem is encountered.
    fatalError("Not implemented yet!")
  }
}

// 10e(1) |^| (2e(2)^3e(3)) = 10e(1) |^| (6(e(2)^e(3))) = 60((e(1)^e(2)^e(3)))
public func |^|<A:Numeric> (_ lhs:(A, e), _ rhs:(A, [e])) -> (A, [e]) {
  if lhs.0 == 0 || rhs.0 == 0 {
    return wedge0()
  }
  if rhs.1.contains(where: { localE in localE == lhs.1 }) {
    return wedge0()
  }
  var arrayE = [e]()
  arrayE.append(lhs.1)
  arrayE.append(contentsOf: rhs.1)
  if grade((0,arrayE)) != grade(rhs) {
    return wedge0()
  }
  return (lhs.0*rhs.0, arrayE)
}

public func |^|<A:Numeric> (_ lhs:[(A, e)], _ rhs:[(A, [e])]) -> [(A, [e])] {
  zip2(with: |^|)(lhs,rhs)
}

public func |^|<A:Numeric> (_ lhs:(A, [e]), _ rhs:(A, e)) -> (A, [e]) {
  rhs |^| lhs
}

public func |^|<A:Numeric> (_ lhs:[(A, [e])], _ rhs:[(A, e)]) -> [(A, [e])] {
  zip2(with: |^|)(lhs,rhs) 
}


//https://www.euclideanspace.com/maths/algebra/vectors/related/bivector/index.htm
//
//public func |^| (_ lhs:(Float, [e]), _ rhs:(Float, [e])) -> (Float, [e]) {
//  var arrayE = [e]()
//  arrayE.append(contentsOf:lhs.1)
//  arrayE.append(contentsOf: rhs.1)
//  // l = [e(1),e(2)]
//  // r = [e(3),e(4)]
//  // --> [(e(1),e(2)),[e(3),e(4)]]
//  if lhs.1.count == rhs.1.count {
//
//  }
//  return (lhs.0*rhs.0, arrayE)
//}

  // (a+b)^(a+b) = a^a + b^a + a^b + b^b = 0
  // a^a = 0 and b^b = 0,
  // a^b = -b^a

  // (a+b+c)^(a+b+c)^(a+b+c)

/*
 func ||| (_ lhs:BasisVector, _ rhs:BasisVector) -> BiVector {
 if lhs.e > rhs.e {
 return BiVector(-1*lhs.coefficient*rhs.coefficient, (rhs.e, lhs.e))
 }
 return BiVector(1*lhs.coefficient*rhs.coefficient, (lhs.e, rhs.e))
 }
 
 func ||| (_ lhs:[BasisVector], _ rhs:[BasisVector]) -> [BiVector] {
 zip2(with: |||) (lhs, rhs)
 }
 
 func |^| (_ lhs:BasisVector, _ rhs:BasisVector) -> BiVector {
 if (lhs.e == rhs.e) {
 // example: e(1) ^ e(1) = 0
 // here we are assuming Grossmann algebra
 return BiVector(0, (lhs.e, rhs.e))
 }
 if lhs.e > rhs.e {
 return BiVector(-1*lhs.coefficient*rhs.coefficient, (rhs.e, lhs.e))
 }
 return BiVector(1*lhs.coefficient*rhs.coefficient, (lhs.e, rhs.e))
 }
 
 func |^| (_ lhs:[BasisVector], _ rhs:[BasisVector]) -> [BiVector] {
 zip2(with: |^|) (lhs, rhs)
 }
 */
