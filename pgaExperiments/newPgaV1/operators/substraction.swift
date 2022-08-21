//import Foundation
//
//
//infix operator |-|:geometricExpressions
//
//public func |-| (_ lhs:Float, _ rhs:Float)  -> BasisVector {
//  BasisVector(e(0), lhs-rhs)
//}
//
//public func |-| (_ lhs:Float, _ rhs:BasisVector) -> [BasisVector] {
//  if rhs.e.index == 0 {
//    return [BasisVector(e(0), lhs-rhs.coefficient)]
//  }
//  return [BasisVector(e(0), lhs), rhs]
//}
//
//public func |-| (_ lhs:BasisVector, _ rhs:Float) -> [BasisVector] {
//  if lhs.e.index == 0 {
//    return [BasisVector(e(0), lhs.coefficient-rhs)]
//  }
//  return [BasisVector(e(0), rhs), lhs]
//}
//
//public func |-| (_ lhs:BasisVector, _ rhs:BasisVector) -> [BasisVector] {
//  if lhs.e == rhs.e {
//    return [BasisVector(lhs.e, lhs.coefficient-rhs.coefficient)]
//  }
//  return [lhs, rhs]
//}
//
//public func |-| (_ lhs:Float, _ rhs:[BasisVector]) -> [BasisVector] {
//  var eSum:Float = 0
//  var rhs = rhs
//  rhs.forEach { gn in
//    if gn.e.index == 0 {
//      eSum += gn.coefficient
//    }
//  }
//  rhs.removeAll { gn in
//    gn.e.index == 0
//  }
//  return [BasisVector(e(0), eSum-lhs)] + rhs
//}
//
//public func |-| (_ lhs:[BasisVector], _ rhs:Float) -> [BasisVector] {
//  rhs |-| lhs
//}
//
//public func |-| (_ lhs:[BasisVector], _ rhs:BasisVector) -> [BasisVector] {
//  var eSum:Float = 0
//  var lhs = lhs
//  lhs.forEach { lgn in
//    if lgn.e == rhs.e {
//      eSum += lgn.coefficient
//    }
//  }
//  
//  lhs.removeAll { gn in
//    gn.e == rhs.e
//  }
//  
//  lhs.append(BasisVector(rhs.e,eSum-rhs.coefficient))
//  return lhs
//}
//
//public func |-| (_ lhs:BasisVector, _ rhs:[BasisVector]) -> [BasisVector] {
//  rhs |-| lhs
//}
//
//public func |-| (_ lhs:[BasisVector], _ rhs:[BasisVector]) -> [BasisVector] {
//  var retVals = [BasisVector]()
//  lhs.forEach { lgn in
//    rhs.forEach { rgn in
//      retVals.append(contentsOf: lgn |+| rgn)
//    }
//  }
//  return retVals
//}
//
//public func |-| (_ lhs:e, _ rhs:e) -> [BasisVector] {
//  if lhs == rhs {
//    return [BasisVector(lhs, 2)]
//  }
//  return [BasisVector(lhs,1), BasisVector(rhs,1)]
//}
