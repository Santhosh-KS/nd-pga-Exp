

public func Inverse(_ basis:e) -> e {
  basis
}

public func Inverse<A:Numeric & FloatingPoint>(_ basis:(A,e) ) -> (A, e) {
  if basis.0 == 0 { fatalError("Divided by zero!") }
  return ( 1/basis.0 , basis.1)
}

public func Inverse<A:Numeric>(_ basis:(A,[e]) ) -> (A, [e]) {
  basis
}

func Inverse<A:Numeric> (_ lhs:e, _ rhs:e) -> (A, [e]) {
  lhs/rhs
}

precedencegroup divisionProcessingOrder {
  associativity:left
  higherThan: additionEvaluation,
              ForwardApplication,
              multiplicationProcessingOrder
}

infix operator |/|:divisionProcessingOrder

func /<A:Numeric> (_ lhs:e, _ rhs:e) -> (A, [e]) {
  let s:A = sign(lhs, rhs)
  if lhs == rhs { return (s+1, []) }
  if lhs > rhs { return (s, [rhs, lhs]) }
  return (s, [lhs, rhs])
}

func /<A:Numeric & FloatingPoint> (_ lhs:(A,e), _ rhs:(A, e)) -> (A, [e]) {
  (Inverse(lhs) |*| Inverse(rhs)).first!
}

//[(Double, [e])]

