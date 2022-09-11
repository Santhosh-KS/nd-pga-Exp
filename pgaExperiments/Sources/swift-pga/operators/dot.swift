
import Foundation


infix operator |||:multiplicationProcessingOrder

func |||<A:Numeric>(_ lhs:A, _ rhs:A) -> A {
  return (lhs * rhs)
}

func |||<A:Numeric>(_ lhs:[A], _ rhs:[A]) -> A {
  zip2(with: |||)(lhs, rhs).reduce(1, |||)
}

func |||<A:Numeric>(_ lhs:e, _ rhs:e) -> A {
  if lhs == rhs { return customDomain()  }
  return A.zero
}

func |||<A:Numeric>(_ lhs:[e], _ rhs:[e]) -> [A] {
  zip2(with: |||)(lhs, rhs)
}


func |||<A:Numeric>(_ lhs:A, _ rhs:e) -> A {
  return A.zero
}

func |||<A:Numeric>(_ lhs:[A], _ rhs:[e]) -> A {
  return A.zero
}

func |||<A:Numeric>(_ lhs:e, _ rhs:A) -> A {
  return A.zero
}

func |||<A:Numeric>(_ lhs:[e], _ rhs:[A]) -> A {
  return A.zero
}

public func|||<A:Numeric> (_ lhs:A, _ rhs:(A,e)) -> A {
  return A.zero
}

func |||<A:Numeric>(_ lhs:(A,e), _ rhs:(A,e)) -> A {
  if lhs.1 == rhs.1 {
    if lhs.1 == e(0) { return A.zero }
    else { return lhs.0 ||| rhs.0 }
  }
  return A.zero
}

public func|||<A:Numeric> (_ lhs:(A,[e]), _ rhs:(A,e)) -> A {
  if lhs.1.count == 1 && lhs.1.first! == rhs.1 { return lhs.0 ||| rhs.0 }
  return A.zero
}

public func|||<A:Numeric> (_ lhs:(A,e), _ rhs:(A,[e])) -> A {
  rhs ||| lhs
}

public func|||<A:Numeric> (_ lhs:[(A,[e])], _ rhs:(A,e)) -> A {
  // here1
  lhs.map { $0 ||| rhs  }.reduce(1, |||)
}

public func|||<A:Numeric> (_ lhs:(A,e), _ rhs:[(A,[e])]) -> A {
  rhs ||| lhs
}

public func |||<A:Numeric> (_ lhs:A, _ rhs:(A, [e])) -> A {
  return A.zero
}

public func |||<A:Numeric> (_ lhs:(A, [e]), _ rhs:A) -> A {
  return A.zero
}

public func|||<A:Numeric> (_ lhs:(A, [e]), _ rhs:(A, [e])) -> A {
  return A.zero
}
