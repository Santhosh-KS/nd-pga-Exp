
import Foundation

func customDomain<A:Numeric>() -> A { A.zero + 1 } // e(i)*e(i) = 1 is the current domain

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

func |||<A:Numeric>(_ lhs:(A,e), _ rhs:(A,e)) -> A {
  if lhs.1 == rhs.1 { return lhs.0 ||| rhs.0}
  return A.zero
}

//
//func |||<A:Numeric>(_ lhs:[A], _ rhs:[e]) -> [A] {
//  zip2(with: |||)(lhs, rhs)
//}
//
//func |||<A:Numeric>(_ lhs:e, _ rhs:A) -> A {
//  return rhs
//}
//
//func |||<A:Numeric>(_ lhs:[e], _ rhs:[A]) -> [A] {
//  zip2(with: |||)(lhs, rhs)
//}
//
//
//func |||<A:Numeric>(_ lhs:(A,e), _ rhs:(A,e)) -> A {
//  if lhs.1 == rhs.1 {
//    return lhs.0 * rhs.0
//  }
//  return A.zero
//}
//
//func |||<A:Numeric>(_ lhs:[(A,e)], _ rhs:[(A,e)]) -> [A]{
//  zip2(with: |||)(lhs, rhs)
//}
//
//func |||<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,[e])) -> (A,[[e]]) {
//  if lhs.1 == rhs.1 {
//    return (lhs.0 ||| rhs.0, [lhs.1,rhs.1])
//  }
//  return (A.zero, [])
//}
//
//func |||<A:Numeric>(_ lhs:[(A,[e])], _ rhs:[(A,[e])]) -> [(A,[[e]])] {
//  zip2(with: |||)(lhs, rhs)
//}
