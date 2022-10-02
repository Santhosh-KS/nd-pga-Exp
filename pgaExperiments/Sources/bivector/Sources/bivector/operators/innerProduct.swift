
import Foundation

infix operator |||:GeometricProductProcessingOrder

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
  (lhs |> unit) ||| (rhs |> unit)
}

func |||<A:Numeric>(_ lhs:(A,e), _ rhs:(A,e)) -> A {
  isEqualBasis(lhs.1, rhs.1) ?
  (isNullBasis(lhs.1) ? 0 : (lhs.0 ||| rhs.0)) : 0
}


func |||<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,[e])) -> (A, [e]) {
  if lhs.1.sorted() == rhs.1.sorted() {
    if contains(lhs.1, e(0)) { return (0, []) }
    else {
      var retVal:(A, [e]) = normalized((lhs.0|||rhs.0, (lhs.1 + rhs.1)))
      retVal.1 = (retVal.1 |> removeDuplicates)
      return retVal
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
/*
 func |||<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,[e])) -> (A, [e]) {
  if lhs.1.sorted() == rhs.1.sorted() {
    var lhsSorted:(A,[e]) = lhs
    var rhsSorted:(A,[e]) = rhs
    if lhs.1.contains(e(0)) {
      lhsSorted = (lhs.0, Array(lhs.1.dropFirst()))
      rhsSorted = (rhs.0, Array(rhs.1.dropFirst()))
    }
    if lhs.1.count == 1 && lhs.1 == [e(0)] { return (lhs.0, [])}
    else {
      var retVal:(A, [e]) = normalized((lhsSorted.0|||rhsSorted.0, (lhsSorted.1 + rhsSorted.1)))
      retVal.1 = (retVal.1 |> removeDuplicates)
      return retVal
    }
  } else {
    if contains(lhs.1, e(0)) && contains(rhs.1, e(0)) { return (rhs.0, []) }
    for re in rhs.1 {
      var retVal:(A, [e]) = normalized((lhs.0|||rhs.0, (lhs.1 + rhs.1)))
      retVal.1 = (retVal.1 |> removeDuplicates)
      if contains(lhs.1, re) { return  retVal }
    }
    return (0, [])
  }
}
 */

func |||<A:Numeric>(_ lhs:[(A,[e])], _ rhs:[(A,[e])]) -> [(A, [e])] {
  var retVal = [(A, [e])]()
  for lmlv in lhs {
    for rmlv in rhs {
      retVal.append((lmlv ||| rmlv))
    }
  }
  return reduce(with: |+|, retVal |> compactMap)
}

func |||<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,e)) -> (A, [e]) {
  lhs ||| (rhs |> arrayfySecond)
}

func |||<A:Numeric>(_ lhs:(A,e), _ rhs:(A,[e])) -> (A, [e]) {
  (lhs |> arrayfySecond) ||| rhs
}

func |||<A:Numeric>(_ lhs:(A,[e]), _ rhs:e) -> (A, [e]) {
  lhs ||| (rhs |> arrayfy)
}

func |||<A:Numeric>(_ lhs:e, _ rhs:(A,[e])) -> (A, [e]) {
  (lhs |> arrayfy) ||| rhs
}

func |||<A:Numeric>(_ lhs:(A,[e]), _ rhs:[e]) -> (A, [e]) {
  lhs ||| (rhs |> unit)
}

func |||<A:Numeric>(_ lhs:[e], _ rhs:(A,[e])) -> (A, [e]) {
  (lhs |> unit) ||| rhs
}

func |||<A:Numeric>(_ lhs:[e], _ rhs:[e]) -> (A, [e]) {
  (lhs |> unit) ||| (rhs |> unit)
}

public func |||<A:Numeric> (_ lhs:A, _ rhs:(A, e)) -> (A,e) {
  (lhs ||| rhs.0, rhs.1)
}

public func |||<A:Numeric> (_ lhs:(A,e), _ rhs:A) -> (A, e) {
  (lhs.0 ||| rhs, lhs.1)
}

public func |||<A:Numeric> (_ lhs:A, _ rhs:(A, [e])) -> (A,[e]) {
  (lhs ||| rhs.0, rhs.1)
}

public func |||<A:Numeric> (_ lhs:(A,[e]), _ rhs:A) -> (A, [e]) {
  (lhs.0 ||| rhs, lhs.1)
}
