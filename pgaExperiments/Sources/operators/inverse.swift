public func Inverse(_ basis:e) -> e {
  basis
}

func Inverse<A:Numeric> (_ lhs:e, _ rhs:e) -> (A, [e]) {
  lhs|/|rhs
}

public func Inverse<A:Numeric & FloatingPoint>(_ basis:(A,e) ) -> (A, e) {
  if basis.0 == 0 { fatalError("Divided by zero!") }
  return ( 1/basis.0 , basis.1)
}

public func Inverse<A:Numeric & FloatingPoint>(_ multiVec:(A,[e]) ) -> (A, [e]) {
//  let revE = Array(multiVec.1.reversed())
  return multiVec |/| ((A.zero+1, multiVec.1))
}

//public func Inverse<A:Numeric & FloatingPoint>(_ multiVec:[(A,[e])] ) -> [(A, [e])] {
//  let nr = multiVec |> map(Inverse)
//  print("before nr = ", nr)
//  let dr = (multiVec |*| nr).first!.0
//  print("dr = ", dr)
//  var retVal = [(A, [e])]()
//  nr.forEach { pairs in
//    retVal.append((pairs.0/dr, pairs.1))
//  }
//  return retVal
//}

precedencegroup DivisionProcessingOrder {
  associativity:left
  higherThan: AdditionEvaluation,
              ForwardApplication,
              MultiplicationProcessingOrder
}

infix operator |/|:DivisionProcessingOrder

func |/|<A:Numeric> (_ lhs:e, _ rhs:e) -> (A, [e]) {
  let s:A = sign(lhs, rhs)
  if lhs == rhs { return (s+1, []) }
  if lhs > rhs { return (s, [rhs, lhs]) }
  return (s, [lhs, rhs])
}

func |/|<A:Numeric & FloatingPoint> (_ lhs:(A,e), _ rhs:(A, e)) -> (A, [e]) {
  (Inverse(lhs) |*| Inverse(rhs)).first!
}

func |/|<A:Numeric & FloatingPoint> (_ lhs:(A,[e]), _ rhs:(A,[e])) -> (A,[e]) {
  (lhs |*| rhs).first!
}

func |/|<A:Numeric & FloatingPoint>(_ lhs: [(A, [e])], _ rhs: [(A, [e])]) -> [(A, [e])] {
  zip2(with: |/|)(lhs, rhs) |> compactMap
}

