
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
    if contains(lhs.1, e(0)) { return (0, []) }
    else {
      if lhs.1.count == 2 { // TODO: Fix this hack e12 ||| e12 = -1 
        return normalized((lhs.0 * rhs.0 * -1, []))
      }
      return normalized((lhs.0 * rhs.0, []))
    }
  } else {
    if contains(lhs.1, e(0)) && contains(rhs.1, e(0)) { return (0, []) }
    for re in rhs.1 {
      var retVal:(A, [e]) = normalized((lhs.0|||rhs.0, (lhs.1 + rhs.1)))
      retVal.1 = (retVal.1 |> removeDuplicates)
      if contains(lhs.1, re) { return  retVal }
    }
    return (0, [])
  }
}

func |||<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,e)) -> (A, [e]) {
  lhs ||| (rhs.0, [rhs.1])
}

func |||<A:Numeric>(_ lhs:(A,e), _ rhs:(A,[e])) -> (A, [e]) {
  (lhs.0, [lhs.1]) ||| rhs
}

func |||<A:Numeric>(_ lhs:(A,[e]), _ rhs:e) -> (A, [e]) {
  lhs ||| (1, [rhs])
}

func |||<A:Numeric>(_ lhs:e, _ rhs:(A,[e])) -> (A, [e]) {
  (1, [lhs]) ||| rhs
}

func |||<A:Numeric>(_ lhs:(A,[e]), _ rhs:[e]) -> (A, [e]) {
  lhs ||| (1, rhs)
}

func |||<A:Numeric>(_ lhs:[e], _ rhs:(A,[e])) -> (A, [e]) {
  (1, lhs) ||| rhs
}

func |||<A:Numeric>(_ lhs:[e], _ rhs:[e]) -> (A, [e]) {
  (1, lhs) ||| (1, rhs)
}
