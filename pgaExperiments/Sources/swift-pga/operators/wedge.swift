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

infix operator |^|:MultiplicationProcessingOrder

public func |^|<A:Numeric> (_ lhs:A, _ rhs:A) -> A {
  return A.zero
}

func |^|<A:Numeric> (_ lhs:[A], _ rhs:[A]) -> A {
  zip2(with: |^|)(lhs, rhs).reduce(1, |^|)
}
//[(1.0, [e(0), e(1)]), (1.0, [e(1), e(2)])]
func |^|(_ lhs:e, _ rhs:e) -> [e] {
  if lhs == rhs  { return [] }
  return [lhs, rhs]
}

func |^|<A:Numeric> (_ lhs:e, _ rhs:e) -> (A, [e]) {
  let s:A = sign(lhs, rhs)
  if lhs == rhs { return (s, [e(0)]) }
  if lhs > rhs { return  (s, rhs |^| lhs) }
  return (s, lhs |^| rhs)
}

func |^|<A:Numeric> (_ lhs:[e], _ rhs:[e]) -> [(A, [e])] {
    //  zip2(with: |^|)(lhs, rhs) // original implementation
    // e0112 = e02
    // [e(0), e(1)] |*| [e(1), e(2)]
    // [e(0)*e(1), e(1)*e(1), e(0)*e(2), e(1)*e(2)]
    // [ 0, [e(0)], 0, [e(1), e(2)]]
    // [[e(0)], [e(1), e(2)]]  --> output of zip2(with: |^|)(lhs, rhs) operation
    // Which is incorrect. hence the below reverse logic is introduced.
  
  if lhs == rhs { return [ (A.zero + 1, [e(0)])]}
  var retVal = [(A,[e])]()
  
    //  let mv1 = [e(0), e(1)]
    //  let mv2 = [e(1), e(2)]
    //  let r:[(Double, [e])] = mv1 |^| mv2
    //  print(r)
    //   |-----------------------|
    // [e(0), e(1)] |*| [e(1), e(2)]
    //         |-----------|
  // This logic doesn't work for trivectors or more as we are using zip2
  // May be to make it work for trivectors/grade-3 we need to change the logic here
  // to have zip3, for grade-4 we need to have zip4 etc.
  let _ = zip2(lhs, Array(rhs.reversed())) |> map { pairs in
    let tmp:(A, [e]) = pairs.0 |^| pairs.1
    if tmp.0 != A.zero && tmp.1 != [e(0)] { retVal.append(tmp) }
  }
  return reduce(with: |^|, retVal)
}

func |^|<A:Numeric> (_ lhs:A, _ rhs:e) -> (A, e) {
  (lhs, rhs)
}

func |^|<A:Numeric> (_ lhs:[A], _ rhs:[e]) -> [(A, e)] {
  zip2(with: |^|)(lhs, rhs)
}

func |^|<A:Numeric> (_ lhs:e, _ rhs:A) -> (A, e) {
  rhs |^| lhs
}

func |^|<A:Numeric> (_ lhs:[e], _ rhs:[A]) -> [(A, e)] {
  zip2(with: |^|)(lhs, rhs)
}

public func|^|<A:Numeric> (_ lhs:A, _ rhs:(A,e)) -> (A,e) {
  if lhs == 0 { return (A.zero, e(0)) }
  return (lhs * rhs.0, rhs.1)
}

func |^|<A:Numeric>(_ lhs:(A,e), _ rhs:(A,e)) -> (A, [e]) {
  let s:A = sign(lhs.1, rhs.1)
  if lhs.1 == rhs.1 {
    return (A.zero, [])
  }
  if lhs.1 > rhs.1 { return ((lhs.0 * rhs.0)*s, [rhs.1, lhs.1]) }
  return ((lhs.0 * rhs.0), [lhs.1, rhs.1])
}

func |^|<A:Numeric>(_ lhs:[(A,e)], _ rhs:[(A,e)]) -> [(A, [e])] {
  zip2(with: |^|)(lhs, rhs)
}

public func|^|<A:Numeric> (_ lhs:(A,[e]), _ rhs:(A,e)) -> (A, [e]) {
  if rhs.1 == e(0) {
    if lhs.1.contains(where: { val in  val == e(0) }) {
      return wedge0()
    }
  }
  var foundSameBasis = false
  lhs.1.forEach { le in
    if le == rhs.1 {
      foundSameBasis = true
    }
  }
  if foundSameBasis { return wedge0() }
  var mv = [e]()
  mv.append(contentsOf: lhs.1)
  mv.append(rhs.1)
  let s:A = sign(mv)
  return (lhs.0 * rhs.0*s, mv.sorted(by: <))
}

public func|^|<A:Numeric> (_ lhs:[(A,[e])], _ rhs:[(A,e)]) -> [(A, [e])] {
  reduce(with: |^|, zip2(with: |^|)(lhs, rhs))
}

public func|^|<A:Numeric> (_ lhs:(A,e), _ rhs:(A,[e])) -> (A, [e]) {
  if lhs.1 == e(0) {
    if rhs.1.contains(where: { val in  val == e(0)}) {
     return wedge0()
    }
  }
  var foundSameBasis = false
  rhs.1.forEach { re in
    if re == lhs.1 {
      foundSameBasis = true
    }
  }
  if foundSameBasis { return wedge0() }
  var mv = [e]()
  mv.append(lhs.1)
  mv.append(contentsOf: rhs.1)
  let s:A = sign(mv)
  return (lhs.0*rhs.0*s, mv.sorted(by: <))
}

public func|^|<A:Numeric> (_ lhs:[(A,e)], _ rhs:[(A,[e])]) -> [(A, [e])] {
  reduce(with: |^|, zip2(with: |^|)(lhs, rhs))
}

public func|^|<A:Numeric> (_ lhs:[(A,[e])], _ rhs:(A,e)) -> [(A,[e])] {
  reduce(with: |^|, lhs.map { $0 |^| rhs })
}

public func|^|<A:Numeric> (_ lhs:(A,e), _ rhs:[(A,[e])]) -> [(A,[e])] {
  reduce(with: |^|, rhs.map { lhs |^| $0 })
}

public func |^|<A:Numeric> (_ lhs:A, _ rhs:(A, [e])) -> (A, [e]) {
  if lhs == 0 || rhs.0 == 0 { return wedge0() }
  return (lhs * rhs.0, rhs.1)
}

public func |^|<A:Numeric> (_ lhs:(A, [e]), _ rhs:A) -> (A, [e]) {
  rhs |^| lhs
}

public func|^|<A:Numeric> (_ lhs:(A, [e]), _ rhs:(A, [e])) -> [(A, [e])] {
  if lhs.0 == A.zero || rhs.0 == A.zero { return [(A.zero,[])] }
  
  if lhs.1.contains(where: { val in  val == e(0)}) {
    if rhs.1.contains(where: { val in  val == e(0)}) {
      return [(A.zero,[])]
    }
  }
  
  let tmp:[(A, [e])] = lhs.1 |^| rhs.1
  var retVal = [(A, [e])]()
//  if tmp.isEmpty { return retVal }
  retVal.append((lhs.0 * tmp.first!.0, tmp.first!.1))
  retVal.append((rhs.0 * tmp.last!.0 , tmp.last!.1))
  return reduce(with: |^|, retVal)
}

public func|^|<A:Numeric> (_ lhs:[(A, [e])], _ rhs:[(A, [e])]) -> [(A, [e])] {
  reduce(with: |||, zip2(with: |^|)(lhs, rhs) |> flatmap)
}

//https://www.euclideanspace.com/maths/algebra/vectors/related/bivector/index.htm
// (a+b)^(a+b) = a^a + b^a + a^b + b^b = 0
// a^a = 0 and b^b = 0,
// a^b = -b^a
// (a+b+c)^(a+b+c)^(a+b+c)


