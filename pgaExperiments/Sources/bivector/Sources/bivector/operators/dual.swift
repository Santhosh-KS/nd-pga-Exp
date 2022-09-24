func dual<A:Numeric>(_ input:(A,[e])) -> (A, [e]) {
  let e0123_local:(A,[e]) = (1, [e(1), e(2), e(3)])
  let retVal = (input |*| e0123_local)
  if retVal.isEmpty  { return (input.0, [e(1), e(2), e(3)]) }
  else { return retVal.first! }
}

func dual<A:Numeric>(_ input:(A,e)) -> (A, [e]) {
  dual((input.0, [input.1]))
}

func dual<A:Numeric>(_ input:e) -> (A, [e]) {
  dual((1, [input]))
}

func dual<A:Numeric>(_ input:A) -> (A, [e]) {
  dual((input, e(0)))
}
