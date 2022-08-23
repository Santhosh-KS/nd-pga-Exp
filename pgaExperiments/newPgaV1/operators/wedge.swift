import Foundation

fileprivate let wedge0:(Float,[e]) = (0,[])
// a  *  b = a . b + a ^ b -- (1)
// a |*| b = a|||b + a|^|b --> Notation Convention equivalent of eq(1)

infix operator |^|:multiplicationProcessingOrder

//s ^ t = t ^ s = st  // Wedge product between scalars.
public func |^| (_ lhs:Float, _ rhs:Float) -> (Float, [e]) {
  (lhs*rhs, [])
}

fileprivate func reduce(_ xs: [(Float, [e])]) -> (Float, [e]) {
  var prod:Float = 1
  xs.forEach { (val:Float, _) in
    prod *= val
  }
  return (prod, [])
}

fileprivate func reduce(_ xs: [(Float, [e])]) -> [(Float, [e])] {
  var compactResult = [(Float,[e])]()
  if xs.isEmpty { return compactResult }
  var previousPairs:(Float,[e]) = xs.first!
  var prod = previousPairs.0
  xs.dropFirst().forEach { currentPairs in
    if currentPairs.1 == previousPairs.1 {
      prod *= currentPairs.0
    } else {
      compactResult.append(previousPairs)
    }
    previousPairs = currentPairs
  }
  compactResult.append(previousPairs)
  return compactResult
}

public func |^| (_ lhs:[Float], _ rhs:[Float]) -> (Float, [e]) {
  zip2(with: |^|)(lhs, rhs) |> reduce
}

//(ta)^b = a^(tb) = t(a^b) // Scalar factorization for the wedge product.
public func |^| (_ lhs:Float, _ rhs:(Float, e)) -> (Float, [e]) {
  (lhs*rhs.0, [rhs.1])
}

public func |^| (_ lhs:[Float], _ rhs:[(Float, e)]) -> [(Float, [e])] {
  zip2(with: |^|)(lhs, rhs) |> (compact >>> reduce)
}

public func |^| (_ lhs:(Float, e), _ rhs:Float) -> (Float, [e]) {
  rhs |^| lhs
}

public func |^| (_ lhs:[(Float, e)], _ rhs:[Float]) -> [(Float, [e])] {
  rhs |^| lhs
}

public func |^| (_ lhs:Float, rhs:e) -> (Float, [e]) {
  if rhs == e0 {
    return (lhs, [])
  }
  return (lhs, [rhs])
}

public func |^| (_ lhs:[Float], rhs:[e]) -> [(Float, [e])] {
 zip2(with: |^|)(lhs, rhs) |> (compact >>> reduce)
}

public func |^| (_ lhs:e, rhs:Float) -> (Float, [e]) {
  rhs |^| lhs
}

public func |^| (_ lhs:[e], rhs:[Float]) -> [(Float, [e])] {
  rhs |^| lhs
}

public func |^| (_ lhs:e, _ rhs:(Float, e)) -> (Float, [e]) {
  if lhs == rhs.1 {
    return wedge0
  }
  return (rhs.0, [lhs, rhs.1])
}

fileprivate func compact(_ xs:[(Float, [e])]) -> [(Float, [e])] {
  var retVal = [(Float,[e])]()
  xs.forEach { pair in
    if pair != wedge0 {
      retVal.append(pair)
    }
  }
  return retVal
}

public func |^| (_ lhs:[e], _ rhs:[(Float, e)]) -> [(Float, [e])] {
  zip2(with: |^|)(lhs, rhs) |> (compact >>> reduce )
}

public func |^| (_ lhs:(Float, e), _ rhs:e) -> (Float, [e]) {
  if lhs.1 == rhs {
    return wedge0
  }
  return (lhs.0, [lhs.1, rhs])
}

public func |^| (_ lhs:[(Float, e)], _ rhs:[e]) -> [(Float, [e])] {
  zip2(with: |^|)(lhs, rhs) |> (compact >>> reduce)
}

public func |^| (_ lhs:e, _ rhs:e) -> (Float, [e]) {
  if lhs == rhs {
    return wedge0
  }
  return (1,[lhs,rhs])
}

public func |^| (_ lhs:[e], _ rhs:[e]) -> [(Float, [e])] {
  zip2(with: |^|)(lhs,rhs) |> (compact >>> reduce)
}

public func |^| (_ lhs:(Float, e), _ rhs:(Float, e)) -> (Float, [e]) {
  if lhs.1 == rhs.1 {
    return wedge0
  }
  return (lhs.0*rhs.0, [lhs.1, rhs.1])
}

public func |^| (_ lhs:[(Float, e)], _ rhs:[(Float, e)]) -> [(Float, [e])] {
//  zip2(with: |^|)(lhs,rhs) |> compact
  var result = [(Float, [e])]()
  if lhs.count == rhs.count {
    lhs.forEach { lpair in
      rhs.forEach { rpair in
        result.append(lpair |^| rpair)
      }
    }
  } else {
    fatalError("Don't know how to do this math yet ☹️")
  }
//  return result
  var result1 = [(Float, [e])]()
  var trunkResult = result.dropFirst()
  result.forEach { outerPair in
    let localE = Array(outerPair.1.reversed())
    trunkResult.forEach { innerPair in
      if localE == innerPair.1 {
        result1.append(((outerPair.0 - innerPair.0), outerPair.1 ))
      }
    }
    trunkResult = trunkResult.dropFirst()
  }
  return result1 |> (compact >>> reduce)
}
// (10, e(1)^e(2)) |^| (5, e(1))
//public func |^| (_ lhs:(Float, [e]), _ rhs:(Float, e)) -> (Float, [e]) {
//
//}

public func antiCommute(_ lhs:(Float,e), _ rhs:(Float,e)) -> (Float,[e]) {
  (-1*rhs.0, rhs.1) |^| lhs
}

public func antiCommute(_ lhs:[(Float,e)], _ rhs:[(Float,e)]) -> [(Float,[e])] {
  zip2(with: antiCommute)(lhs, rhs) |> (compact >>> reduce)
}

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
public func |^| (_ lhs:(Float,[e]), _ rhs:(Float,[e])) -> (Float,[e]) {
  fatalError("Not supported yet")
}

// 10e(1) |^| (2e(2)^3e(3)) = 10e(1) |^| (6(e(2)^e(3))) = 60((e(1)^e(2)^e(3)))
public func |^| (_ lhs:(Float, e), _ rhs:(Float, [e])) -> (Float, [e]) {
  if lhs.0 == 0 || rhs.0 == 0 {
    return wedge0
  }
  if rhs.1.contains(where: { localE in localE == lhs.1 }) {
    return wedge0
  }
  var arrayE = [e]()
  arrayE.append(lhs.1)
  arrayE.append(contentsOf: rhs.1)
  if grade((0,arrayE)) != grade(rhs) {
    return wedge0
  }
  return (lhs.0*rhs.0, arrayE)
}

public func |^| (_ lhs:[(Float, e)], _ rhs:[(Float, [e])]) -> [(Float, [e])] {
  zip2(with: |^|)(lhs,rhs) |> (compact >>> reduce)
}

public func |^| (_ lhs:(Float, [e]), _ rhs:(Float, e)) -> (Float, [e]) {
  rhs |^| lhs
}

public func |^| (_ lhs:[(Float, [e])], _ rhs:[(Float, e)]) -> [(Float, [e])] {
  zip2(with: |^|)(lhs,rhs) |> (compact >>> reduce)
}


public func grade(_ mvs:(Float, [e])) -> UInt8 {
  if mvs.1.isEmpty { return 0}
  return mvs.1.max()!.index
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
