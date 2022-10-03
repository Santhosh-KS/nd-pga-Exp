
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
  (lhs |> unitVector) ||| (rhs |> unitVector)
}

func |||<A:Numeric>(_ lhs:(A,e), _ rhs:(A,e)) -> A {
  isEqualBasis(lhs.1, rhs.1) ?
  (isNullBasis(lhs.1) ? 0 : (lhs.0 ||| rhs.0)) : 0
}

func evaluate<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A, [e])) -> (A, [e]) {
  var retVal:(A, [e]) = normalized((lhs.0|||rhs.0, (lhs.1 + rhs.1)))
  retVal.1 = (retVal.1 |> removeDuplicates)
  return retVal
}

func |||<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,[e])) -> (A, [e]) {
  let lhsGrade = grade(lhs)
  let rhsGrade = grade(rhs)
  if (lhsGrade == 0 || rhsGrade == 0) { return (0, []) }
  if lhsGrade == 1 {
    if lhs.1 == [e(0)] || rhs.1 == [e(0)] { return (0, []) }
    if !contains(rhs.1, lhs.1.first!) { return (0, []) }
    else {
      return evaluate(lhs, rhs)
    }
  }
  else {
    if contains(rhs.1, e(0)) && contains(lhs.1, e(0)) { return (0, [])}
    if rhsGrade == 1 {
      if !contains(lhs.1, rhs.1.first!) { return (0, []) }
      else {
        return evaluate(lhs, rhs)
      }
    }
    else {
      var matchCount = 0
      for x in 0..<grade(lhs) {
        if contains(rhs.1, lhs.1[Int(x)]) { matchCount += 1 }
      }
      if matchCount == grade(lhs) { return evaluate(lhs, rhs) }
      
      matchCount = 0
      for x in 0..<grade(rhs) {
        if contains(lhs.1, rhs.1[Int(x)]) { matchCount += 1 }
      }
      if matchCount == grade(rhs) { return evaluate(lhs, rhs) }
      else { return (0, []) }
    }
  }
}

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
  lhs ||| (rhs |> unitVector)
}

func |||<A:Numeric>(_ lhs:[e], _ rhs:(A,[e])) -> (A, [e]) {
  (lhs |> unitVector) ||| rhs
}

func |||<A:Numeric>(_ lhs:[e], _ rhs:[e]) -> (A, [e]) {
  (lhs |> unitVector) ||| (rhs |> unitVector)
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
