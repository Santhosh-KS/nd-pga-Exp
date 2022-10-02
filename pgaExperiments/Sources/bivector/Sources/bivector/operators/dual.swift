func dual<A:Numeric>(with pseudoScalar:(A,[e]), of input:(A,[e])) -> (A,[e]) {
  var retVal = [(A,[e])]()
  if input.1 == [e(0)] || grade(input) == 3 {
    retVal = (pseudoScalar |*| input)
  } else {
    retVal = (input |*| pseudoScalar)
  }
  if retVal.isEmpty  {
    return (pseudoScalar.0 * input.0, Array(pseudoScalar.1.dropFirst()))
  }
  else { return retVal.first! }
}

func dual<A:Numeric>(_ input:(A,[e])) -> (A, [e]) {
  let pseudoScalar:(A,[e]) = (1, [e(0), e(1), e(2), e(3)])
  return (pseudoScalar, input) |> dual(with:of:)
}

func dual<A:Numeric>(_ input:[(A,[e])]) -> [(A, [e])] {
  input.map(dual)
}

func dual<A:Numeric>(_ input:(A,e)) -> (A, [e]) {
  input |> arrayfySecond >>> dual
}

func dual<A:Numeric>(_ input:e) -> (A, [e]) {
  input |> unitVector >>> arrayfySecond >>> dual
}

func dual<A:Numeric>(_ input:[e]) -> (A, [e]) {
  input |> unitVector >>> dual
}

func dual<A:Numeric>(_ input:A) -> (A, [e]) {
  (input, e(0)) |> dual
}

//let dual_in_3dpga:((Double, [e])) -> ((Double, [e])) = curry(dual(with:of:))(e123)

prefix operator |!|

public prefix func |!|<A:Numeric>(_ input:(A,e)) -> (A, [e]) {
  input |> dual
}

prefix func |!|<A:Numeric>(_ input:(A,[e])) -> (A, [e]) {
  input |> dual
}

prefix func |!|<A:Numeric>(_ input:[(A,[e])]) -> [(A, [e])] {
  input |> dual
}

prefix func |!|<A:Numeric>(_ input:e) -> (A, [e]) {
  input |> dual
}

prefix func |!|<A:Numeric>(_ input:[e]) -> (A, [e]) {
  input |> dual
}
prefix func |!|<A:Numeric>(_ input:A) -> (A, [e]) {
  input |> dual
}

prefix func |!|<A:Numeric>(_ input:[A]) -> (A, [e]) {
  input.reduce(0, |+|) |> dual
}
