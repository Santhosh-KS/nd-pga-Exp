////
////  bakup.swift
////  pgaExperiments
////
////  Created by Santhosh K S on 18/08/22.
////
//
//import Foundation
//
//
//public struct GeometricNumber {
//  let e:[e]
//  let coefficient:Float
//}
//
//public extension GeometricNumber {
//  init(_ es:e...) {
//    e = es
//    coefficient = 1
//  }
//  
//  init(_ es:e..., with coef:Float...) {
//    zip(es,coef).map { (first:e, second:Float) in
//      
//    }
//      //    if es.count == coef.count {
//      //      e = es
//      //      coefficient = coef.reduce(1, *)
//      //    }
//      //    else {
//      //      fatalError("Count of e \(es.count) != \(coef.count), coefficients count")
//      //    }
//  }
//}
//
//extension GeometricNumber : CustomStringConvertible {
//  public var description: String {
//    var str = "\(coefficient)*e("
//    str += e.map { (v:e)->String in
//      "\(v.index)"
//    }.joined(separator: ",")
//    str += ")"
//    return str
//  }
//}
//
//extension GeometricNumber: Equatable {}
