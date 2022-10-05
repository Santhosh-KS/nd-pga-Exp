precedencegroup SandwichProductProcessingOrder {
  associativity:left
  higherThan: AdditionEvaluation, ForwardApplication
  lowerThan: MultiplicationPrecedence, AdditionPrecedence
}

infix operator |<*>|:SandwichProductProcessingOrder

public func |<*>|<A:FloatingPoint>(_ lhs:A, _ rhs:A) -> A {
  lhs |*| rhs |*| |~|lhs
}

public func |<*>|<A:FloatingPoint>(_ lhs:[A], _ rhs:[A]) -> A {
  lhs.reduce(1, |*|) |<*>| rhs.reduce(1, |*|)
}

public func |<*>|<A:FloatingPoint>(_ lhs:(A,e), _ rhs:(A,e)) -> (A, [e]) {
  lhs |*| rhs |*| |~|lhs
}

public func |<*>|<A:FloatingPoint>(_ lhs:(A,[e]), _ rhs:(A,[e])) -> (A, [e]) {
  lhs |*| rhs |*| |~|lhs
}

public func |<*>|<A:FloatingPoint>(_ lhs:A, _ rhs:e) -> (A,[e]){
  lhs |*| rhs |*| |~|lhs
}

// (A,[e]) as return is expected.  Here 'lhs' is a vector and 'rhs' is a scalar
// so e |*| ~e returns [e]
public func |<*>|<A:FloatingPoint>(_ lhs:e, _ rhs:A) -> (A,[e]){
  (lhs |> unitVector) |*| rhs |*| |~|lhs
}

// (A,[e]) as return is expected. Here 'lhs' is a vector and 'rhs' is a scalar
// so (A, e) |*| ~(A, e) returns (A, [e])
public func |<*>|<A:FloatingPoint>(_ lhs:(A,e), _ rhs:A) -> (A, [e]) {
  lhs |*| rhs |*| |~|lhs
}

public func |<*>|<A:FloatingPoint>(_ lhs:A, _ rhs:(A,e)) -> (A, e) {
  lhs |*| rhs |*| |~|lhs
}

public func |<*>|<A:FloatingPoint>(_ lhs:e, _ rhs:e) -> (A, [e]) {
  (lhs |> unitVector) |<*>| (rhs |> unitVector)
}

public func |<*>|<A:FloatingPoint>(_ lhs:e, _ rhs:(A,e)) -> (A, [e]) {
  (lhs |> unitVector) |<*>| rhs
}

public func |<*>|<A:FloatingPoint>(_ lhs:(A,e), _ rhs:e) -> (A, [e]) {
  lhs |<*>| (rhs |> unitVector)
}

public func |<*>|<A:FloatingPoint>(_ lhs:[e], _ rhs: (A,[e])) -> (A, [e]) {
  (lhs |> unitVector) |<*>| rhs
}

public func |<*>|<A:FloatingPoint>(_ lhs:(A,[e]), _ rhs: [e]) -> (A, [e]) {
  lhs |<*>| (rhs |> unitVector)
}

public func |<*>|<A:FloatingPoint>(_ lhs:[e], _ rhs: [e]) -> (A, [e]) {
  (lhs |> unitVector) |<*>| (rhs |> unitVector)
}

public func |<*>|<A:FloatingPoint>(_ lhs:A, _ rhs:(A,[e])) -> (A, [e]) {
  (lhs, []) |<*>| rhs
}

public func |<*>|<A:FloatingPoint>(_ lhs:(A,[e]), _ rhs:A) -> (A, [e]) {
  lhs |<*>| (rhs, [])
}

public func |<*>|<A:FloatingPoint>(_ lhs:(A,[e]), _ rhs:e) -> (A, [e]) {
  lhs |<*>| (rhs |> unitVector >>> arrayfySecond)
}

public func |<*>|<A:FloatingPoint>(_ lhs:e, _ rhs: (A,[e])) -> (A, [e]) {
  (lhs |> unitVector >>> arrayfySecond) |<*>| rhs
}

