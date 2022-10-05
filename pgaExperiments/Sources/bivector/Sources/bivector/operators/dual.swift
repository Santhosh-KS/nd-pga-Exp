func dual<A:FloatingPoint>(with pseudoScalar:(A,[e]), of input:(A,[e])) -> (A,[e]) {
  var modifiedMulVec = [e]()
  for elem in pseudoScalar.1 {
    if !contains(input.1, elem) { modifiedMulVec.append(elem) }
  }
  let nps = (pseudoScalar.0, modifiedMulVec)
  let retVal = input |*| nps
  modifiedMulVec.removeAll()
  for elem in nps.1 {
    if !contains(input.1, elem) { modifiedMulVec.append(elem)}
  }
  return (retVal.0, modifiedMulVec)
 
  
    //  let g = grade(input)
    //  if g == 0 { return (input.0, Array(pseudoScalar.1.dropFirst())) }
    //  else if g == 4 { return (input.0, [])}
    //  else {
    //
    ////    var retVal:(A,[e])
    //    if contains(input.1, e(0)) {
    //      let retVal = (pseudoScalar.0, Array(pseudoScalar.1.dropFirst())) |*| input
    //      return retVal
    //    }
    //    retVal = (pseudoScalar |*| input)
  
    //    if input.1 == [e(0)] || grade(input) == 3 {
    //
    //    } else {
    //      retVal = (input |*| pseudoScalar)
    //    }
    //    return (0,[])
}


func dual<A:FloatingPoint>(_ input:(A,[e])) -> (A, [e]) {
  let pseudoScalar:(A,[e]) = (1, [e(0), e(1), e(2), e(3)])
//  return (pseudoScalar, input) |> dual(with:of:)
  return dual(with: pseudoScalar, of: input)
}

func dual<A:FloatingPoint>(_ input:[(A,[e])]) -> [(A, [e])] {
  input.map(dual)
}

func dual<A:FloatingPoint>(_ input:(A,e)) -> (A, [e]) {
  input |> arrayfySecond >>> dual
}

func dual<A:FloatingPoint>(_ input:e) -> (A, [e]) {
  input |> unitVector >>> arrayfySecond >>> dual
}

func dual<A:FloatingPoint>(_ input:[e]) -> (A, [e]) {
  input |> unitVector >>> dual
}

func dual<A:FloatingPoint>(_ input:A) -> (A, [e]) {
  (input, e(0)) |> dual
}

//let dual_in_3dpga:((Double, [e])) -> ((Double, [e])) = curry(dual(with:of:))(e123)

prefix operator |!|

public prefix func |!|<A:FloatingPoint>(_ input:(A,e)) -> (A, [e]) {
  input |> dual
}

prefix func |!|<A:FloatingPoint>(_ input:(A,[e])) -> (A, [e]) {
//  input |> dual
  dual(input)
}

prefix func |!|<A:FloatingPoint>(_ input:[(A,[e])]) -> [(A, [e])] {
  input |> dual
}

prefix func |!|<A:FloatingPoint>(_ input:e) -> (A, [e]) {
  input |> dual
}

prefix func |!|<A:FloatingPoint>(_ input:[e]) -> (A, [e]) {
  input |> dual
}
prefix func |!|<A:FloatingPoint>(_ input:A) -> (A, [e]) {
  input |> dual
}

prefix func |!|<A:FloatingPoint>(_ input:[A]) -> (A, [e]) {
  input.reduce(0, |+|) |> dual
}
