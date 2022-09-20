
public func Inverse<A:Numeric>(_ basis:(A,e)) -> (A, e) {
  basis
}

public func Inverse<A:Numeric>(_ basis:e) -> (A,e) {
  Inverse((1,basis))
}

public func Inverse<A:Numeric>(_ basis:(A,[e])) -> (A, [e]) {
  let v = (basis |*| basis).first!
  return v
}

//precedencegroup DivisionProcessingOrder {
//  associativity:left
//  higherThan: AdditionEvaluation,
//  ForwardApplication,
//  MultiplicationProcessingOrder
//}
//
//infix operator |/|:DivisionProcessingOrder
