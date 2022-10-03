//import Foundation
//
//precedencegroup GeometricProductProcessingOrder {
//  associativity:left
//  higherThan: AdditionEvaluation, ForwardApplication,
//  RegressiveProductProcessingOrder, SandwichProductProcessingOrder
//  lowerThan: MultiplicationPrecedence, AdditionPrecedence, AssignmentPrecedence
//}
//
//infix operator |*|:GeometricProductProcessingOrder
//
//func half<A:Numeric & FloatingPoint>(_ x:A) -> A {
//  x/2
//}
//
//func half<A:Numeric & FloatingPoint>(_ vec:(A,e)) -> (A,e) {
//  (vec.0 |> half, vec.1)
//}
//
//func half<A:Numeric & FloatingPoint>(_ vec:(A,[e])) -> (A,[e]) {
//  (vec.0 |> half, vec.1)
//}
//
//func half<A:Numeric & FloatingPoint>(_ vecs:[(A,[e])]) -> [(A,[e])] {
//  vecs.map(half)
//}
//
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:A, _ rhs:A) -> A {
//  let dot = (lhs ||| rhs) |> half
//  let wedge = (lhs |^| rhs) |> half
//  return dot |+| wedge
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:[A], _ rhs:[A]) -> A {
//  let dot = (lhs ||| rhs) |> half
//  let wedge = (lhs |^| rhs) |> half
//  return dot |+| wedge
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:A, _ rhs:e) -> (A,[e]) {
////  lhs |^| rhs
////  ((lhs ||| rhs |+| lhs |^| rhs).first!)
//  let dot = (lhs ||| rhs) |> half
//  let wedge = (lhs |^| rhs) |> half
//  return (dot |+| wedge).first!
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:e, _ rhs:A) -> (A,[e]) {
////  lhs |^| rhs
////  (lhs ||| rhs |+| lhs |^| rhs).first!
//  let dot = (lhs ||| rhs) |> half
//  let wedge = (lhs |^| rhs) |> half
//  return (dot |+| wedge).first!
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:[A], _ rhs:e) -> (A,[e]) {
////  lhs |^| rhs
////  (lhs ||| rhs |+| lhs |^| rhs).first!
//  let dot = (lhs ||| rhs) |> half
//  let wedge = (lhs |^| rhs) |> half
//  return (dot |+| wedge).first!
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:e, _ rhs:[A]) -> (A,[e]) {
////  rhs |^| lhs
////  (lhs ||| rhs |+| lhs |^| rhs).first!
//  let dot = (lhs ||| rhs) |> half
//  let wedge = (lhs |^| rhs) |> half
//  return (dot |+| wedge).first!
//}
//
//public func |*|<A:Numeric & FloatingPoint> (_ lhs:(A,e), _ rhs:(A, e)) -> (A, [e]) {
////  (lhs |^| rhs)
////  (lhs ||| rhs |+| lhs |^| rhs).first!
//  let dot = (lhs ||| rhs) |> half
//  let wedge = (lhs |^| rhs) |> half
//  return (dot |+| wedge).first!
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:e, _ rhs:e) -> (A, [e]) {
//  (lhs |> unitVector) |*| (rhs |> unitVector)
//}
//
//public func |*|<A:Numeric & FloatingPoint> (_ lhs:e, _ rhs:(A, e)) -> (A, [e]) {
//  (lhs |> unitVector) |*| rhs
//}
//
//public func |*|<A:Numeric & FloatingPoint> (_ lhs:(A, e), _ rhs:e) -> (A, [e]) {
//  lhs |*| (rhs |> unitVector)
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:(A,[e]), _ rhs:(A,[e])) -> [(A, [e])] {
////  (lhs ||| rhs |+| lhs |^| rhs) |> compactMap
//  let dot = (lhs ||| rhs) |> half
//  let wedge = (lhs |^| rhs) |> half
//  return (dot |+| wedge) |> compactMap
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:(A,[e]), _ rhs:(A,e)) -> [(A, [e])] {
//  lhs |*| (rhs |> arrayfySecond)
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:(A,e), _ rhs:(A,[e])) -> [(A, [e])] {
//  (lhs |> arrayfySecond) |*| rhs
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:(A,[e]), _ rhs:e) -> [(A, [e])] {
//  lhs |*| (rhs |> arrayfy)
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:e, _ rhs: (A,[e])) -> [(A, [e])] {
//  (lhs |> arrayfy) |*| rhs
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:(A,[e]), _ rhs:[e]) -> [(A, [e])] {
//  lhs |*| (rhs |> unitVector)
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:[e], _ rhs: (A,[e])) -> [(A, [e])] {
//  (lhs |> unitVector) |*| rhs
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:[e], _ rhs: [e]) -> [(A, [e])] {
//  (lhs |> unitVector) |*| (rhs |> unitVector)
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:A, _ rhs:(A,[e])) -> (A, [e]) {
//  ((lhs, []) |*| rhs).first!
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:(A,[e]), _ rhs:A) -> (A, [e]) {
//  (lhs |*| (rhs, [])).first!
//}
//
//public func |*|<A:Numeric & FloatingPoint>(_ lhs:[(A,[e])], _ rhs:[(A,[e])]) -> [(A, [e])] {
//  var retVal = [(A, [e])]()
//  for lmlv in lhs {
//    for rmlv in rhs {
//      let prod = (lmlv |*| rmlv)
//      if !prod.isEmpty { retVal.append(prod.first!)}
//    }
//  }
//  return reduce(with: |+|, retVal |> half) |> compactMap
//}
//
//public func |*|<A:Numeric & FloatingPoint & FloatingPoint> (_ lhs:A, _ rhs:(A, e)) -> (A,e) {
//  (lhs|*|rhs.0, rhs.1)
//}
//
//public func |*|<A:Numeric & FloatingPoint & FloatingPoint> (_ lhs:(A,e), _ rhs:A) -> (A, e) {
//  (lhs.0|*|rhs, lhs.1)
//}
//
