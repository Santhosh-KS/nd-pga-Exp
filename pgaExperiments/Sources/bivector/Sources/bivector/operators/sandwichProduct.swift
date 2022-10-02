precedencegroup SandwichProductProcessingOrder {
  associativity:left
  higherThan: AdditionEvaluation, ForwardApplication
  lowerThan: MultiplicationPrecedence, AdditionPrecedence
}

infix operator |<*>|:SandwichProductProcessingOrder

public func |<*>|<A:Numeric>(_ lhs:A, _ rhs:A) -> A {
  lhs |*| rhs |*| |~|lhs
}

public func |<*>|<A:Numeric>(_ lhs:[A], _ rhs:[A]) -> A {
  lhs.reduce(1, |*|) |<*>| rhs.reduce(1, |*|)
}

public func |<*>|<A:Numeric>(_ lhs:(A,e), _ rhs:(A,e)) -> (A, [e]) {
  (lhs |*| rhs |*| |~|lhs).first!
}

public func |<*>|<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,[e])) -> [(A, [e])] {
  lhs |*| rhs |*| [|~|lhs]
}

public func |<*>|<A:Numeric>(_ lhs:A, _ rhs:e) -> (A,e){
  lhs |*| rhs |*| |~|lhs
}

// (A,[e]) as return is expected.  Here 'lhs' is a vector and 'rhs' is a scalar
// so e |*| ~e returns [e]
public func |<*>|<A:Numeric>(_ lhs:e, _ rhs:A) -> (A,[e]){
  lhs |*| rhs |*| |~|lhs
}

// (A,[e]) as return is expected. Here 'lhs' is a vector and 'rhs' is a scalar
// so (A, e) |*| ~(A, e) returns (A, [e])
public func |<*>|<A:Numeric>(_ lhs:(A,e), _ rhs:A) -> (A, [e]) {
  lhs |*| rhs |*| |~|lhs
}

public func |<*>|<A:Numeric>(_ lhs:A, _ rhs:(A,e)) -> (A, e) {
  lhs |*| rhs |*| |~|lhs
}

public func |<*>|<A:Numeric>(_ lhs:e, _ rhs:e) -> (A, [e]) {
  (lhs |> unit) |<*>| (rhs |> unit)
}

public func |<*>|<A:Numeric>(_ lhs:e, _ rhs:(A,e)) -> (A, [e]) {
  (lhs |> unit) |<*>| rhs
}

public func |<*>|<A:Numeric>(_ lhs:(A,e), _ rhs:e) -> (A, [e]) {
  lhs |<*>| (rhs |> unit)
}

public func |<*>|<A:Numeric>(_ lhs:[e], _ rhs: (A,[e])) -> [(A, [e])] {
  (lhs |> unit) |<*>| rhs
}

public func |<*>|<A:Numeric>(_ lhs:(A,[e]), _ rhs: [e]) -> [(A, [e])] {
  lhs |<*>| (rhs |> unit)
}

public func |<*>|<A:Numeric>(_ lhs:[e], _ rhs: [e]) -> [(A, [e])] {
  (lhs |> unit) |<*>| (rhs |> unit)
}

public func |<*>|<A:Numeric>(_ lhs:A, _ rhs:(A,[e])) -> (A, [e]) {
  ((lhs, []) |<*>| rhs).first!
}

public func |<*>|<A:Numeric>(_ lhs:(A,[e]), _ rhs:A) -> (A, [e]) {
  (lhs |<*>| (rhs, [])).first!
}

public func |<*>|<A:Numeric>(_ lhs:(A,[e]), _ rhs:e) -> [(A, [e])] {
  lhs |<*>| (rhs |> unit >>> arrayfySecond)
}

public func |<*>|<A:Numeric>(_ lhs:e, _ rhs: (A,[e])) -> [(A, [e])] {
  (lhs |> unit >>> arrayfySecond) |<*>| rhs
}
