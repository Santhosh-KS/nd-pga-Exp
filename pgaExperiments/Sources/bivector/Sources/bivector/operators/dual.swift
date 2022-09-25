func dual<A:Numeric>(with pseudoScalar:(A,[e]), of input:(A,[e])) -> (A,[e]) {
  let retVal = (input |*| pseudoScalar)
  if retVal.isEmpty  { return pseudoScalar }
  else { return retVal.first! }
}

func dual<A:Numeric>(_ input:(A,[e])) -> (A, [e]) {
  let pseudoScalar:(A,[e]) = (1, [e(1), e(2), e(3)])
  return dual(with: pseudoScalar, of: input)
}

func dual<A:Numeric>(_ input:[(A,[e])]) -> [(A, [e])] {
  input.map(dual)
}

func dual<A:Numeric>(_ input:(A,e)) -> (A, [e]) {
  dual((input.0, [input.1]))
}

func dual<A:Numeric>(_ input:e) -> (A, [e]) {
  dual((1, [input]))
}

func dual<A:Numeric>(_ input:[e]) -> (A, [e]) {
  dual((1, input))
}

func dual<A:Numeric>(_ input:A) -> (A, [e]) {
  dual((input, e(0)))
}

let dual_in_3dpga:((Double, [e])) -> ((Double, [e])) = curry(dual(with:of:))(e123)

prefix operator |!|

public prefix func |!|<A:Numeric>(_ input:(A,e)) -> (A, [e]) {
  dual(input)
}

prefix func |!|<A:Numeric>(_ input:(A,[e])) -> (A, [e]) {
  dual(input)
}

prefix func |!|<A:Numeric>(_ input:[(A,[e])]) -> [(A, [e])] {
  dual(input)
}

prefix func |!|<A:Numeric>(_ input:e) -> (A, [e]) {
  dual(input)
}

prefix func |!|<A:Numeric>(_ input:[e]) -> (A, [e]) {
  dual(input)
}
prefix func |!|<A:Numeric>(_ input:A) -> (A, [e]) {
  dual(input)
}

prefix func |!|<A:Numeric>(_ input:[A]) -> (A, [e]) {
  dual(input.reduce(0, |+|))
}
