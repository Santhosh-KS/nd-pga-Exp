
import Foundation

infix operator |||:MultiplicationProcessingOrder

func |||<A:Numeric>(_ lhs:A, _ rhs:A) -> A {
  (lhs * rhs)
}

func |||<A:Numeric>(_ lhs:[A], _ rhs:[A]) -> A {
  lhs.reduce(1, |||) ||| rhs.reduce(1, |||)
}

func |||<A:Numeric>(_ lhs:A, _ rhs:e) -> (A, e) {
  rhs |^| lhs
}

func |||<A:Numeric>(_ lhs:e, _ rhs:A) -> (A, e) {
  rhs |^| lhs
}

func |||<A:Numeric>(_ lhs:[A], _ rhs:e) -> (A, e) {
  lhs |^| rhs
}

func |||<A:Numeric>(_ lhs:e, _ rhs:[A]) -> (A, e) {
  rhs |^| lhs
}

func |||<A:Numeric>(_ lhs:e, _ rhs:e) -> A {
  (1, lhs) ||| (1, rhs)
}

func |||<A:Numeric>(_ lhs:(A,e), _ rhs:(A,e)) -> A {
  isEqualBasis(lhs.1, rhs.1) ?
  (isNullBasis(lhs.1) ? 0 : (lhs.0 ||| rhs.0)) : 0
}

func |||<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,[e])) -> (A, [e]) {
  if lhs.1.sorted() == rhs.1.sorted() {
    if lhs.1 == [e(0)] { return (0, []) }
    return normalized((lhs.0|||rhs.0, []))
  }
  for re in rhs.1 {
    if contains(lhs.1, re) { return normalized((lhs.0|||rhs.0, (lhs.1 + rhs.1))) }
  }
  return (0, [])
}
