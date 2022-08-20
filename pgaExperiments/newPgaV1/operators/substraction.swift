//import Foundation
//
//
//infix operator |-|:geometricExpressions
//
//public func |-| (_ lhs:Float, _ rhs:Float)  -> GeometricNumber {
//  GeometricNumber(e(0), lhs-rhs)
//}
//
//public func |-| (_ lhs:Float, _ rhs:GeometricNumber) -> [GeometricNumber] {
//  if rhs.e.index == 0 {
//    return [GeometricNumber(e(0), lhs-rhs.coefficient)]
//  }
//  return [GeometricNumber(e(0), lhs), rhs]
//}
//
//public func |-| (_ lhs:GeometricNumber, _ rhs:Float) -> [GeometricNumber] {
//  if lhs.e.index == 0 {
//    return [GeometricNumber(e(0), lhs.coefficient-rhs)]
//  }
//  return [GeometricNumber(e(0), rhs), lhs]
//}
//
//public func |-| (_ lhs:GeometricNumber, _ rhs:GeometricNumber) -> [GeometricNumber] {
//  if lhs.e == rhs.e {
//    return [GeometricNumber(lhs.e, lhs.coefficient-rhs.coefficient)]
//  }
//  return [lhs, rhs]
//}
//
//public func |-| (_ lhs:Float, _ rhs:[GeometricNumber]) -> [GeometricNumber] {
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
//  return [GeometricNumber(e(0), eSum-lhs)] + rhs
//}
//
//public func |-| (_ lhs:[GeometricNumber], _ rhs:Float) -> [GeometricNumber] {
//  rhs |-| lhs
//}
//
//public func |-| (_ lhs:[GeometricNumber], _ rhs:GeometricNumber) -> [GeometricNumber] {
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
//  lhs.append(GeometricNumber(rhs.e,eSum-rhs.coefficient))
//  return lhs
//}
//
//public func |-| (_ lhs:GeometricNumber, _ rhs:[GeometricNumber]) -> [GeometricNumber] {
//  rhs |-| lhs
//}
//
//public func |-| (_ lhs:[GeometricNumber], _ rhs:[GeometricNumber]) -> [GeometricNumber] {
//  var retVals = [GeometricNumber]()
//  lhs.forEach { lgn in
//    rhs.forEach { rgn in
//      retVals.append(contentsOf: lgn |+| rgn)
//    }
//  }
//  return retVals
//}
//
//public func |-| (_ lhs:e, _ rhs:e) -> [GeometricNumber] {
//  if lhs == rhs {
//    return [GeometricNumber(lhs, 2)]
//  }
//  return [GeometricNumber(lhs,1), GeometricNumber(rhs,1)]
//}
