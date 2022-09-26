precedencegroup RegressiveProductProcessingOrder {
  associativity:left
  higherThan: AdditionEvaluation, ForwardApplication, SandwichProductProcessingOrder
  lowerThan: MultiplicationPrecedence, AdditionPrecedence
}

infix operator |&*|:RegressiveProductProcessingOrder

// TODO: FIXME: Not sure if regressive product
// ( a ∨ b ) = (a∗ ∧ b∗)∗ Regressive Product
// as mentioned in https://bivector.net/3DPGA.pdf
// i.e
// (a |&*| b) = dual(dual(a) |^| dual(b)) --- (1)
// OR
// (a |&*| b) = dual(a) |^| dual(b)  --- (2)
// with eq(1) definition results are not matching with https://bivector.net/tools.html
// where as eq(2) results match with the https://bivector.net/tools.html
// Once this issue is fixed add more unittests.

// UPDATE: Based on the current understanding eq(2) implementation is followed.
// https://github.com/Santhosh-KS/nd-pga-Exp/blob/main/pgaExperiments/Sources/bivector/table.md
// table matches more closely with the table presented in https://bivector.net/tools.html

public func |&*|<A:Numeric>(_ lhs:A, _ rhs:A) -> (A, [e]) {
//  dual(dual(lhs) |^| dual(rhs))
  dual(lhs) |^| dual(rhs)
}

public func |&*|<A:Numeric>(_ lhs:[A], _ rhs:[A]) -> (A, [e]) {
//  dual(dual(lhs.reduce(1,*)) |^| dual(rhs.reduce(1, *)))
  dual(lhs.reduce(1,*)) |^| dual(rhs.reduce(1, *))
}

public func |&*|<A:Numeric>(_ lhs:A, _ rhs:e) -> (A, [e]) {
//  dual(dual(lhs) |^| dual(rhs))
  dual(lhs) |^| dual(rhs)
}

public func |&*|<A:Numeric>(_ lhs:e, _ rhs:A) -> (A, [e]) {
//  dual(dual(lhs) |^| dual(rhs))
  dual(lhs) |^| dual(rhs)
}

public func |&*|<A:Numeric>(_ lhs:A, _ rhs:(A,e)) -> (A, [e]) {
//  dual(dual(lhs) |^| dual(rhs))
  dual(lhs) |^| dual(rhs)
}

public func |&*|<A:Numeric>(_ lhs:(A,e), _ rhs:A) -> (A, [e]) {
//  dual(dual(lhs) |^| dual(rhs))
  dual(lhs) |^| dual(rhs)
}

public func |&*|<A:Numeric>(_ lhs:(A,e), _ rhs:e) -> (A, [e]) {
//  dual(dual(lhs) |^| dual((1, rhs)))
  dual(lhs) |^| dual(rhs)
}

public func |&*|<A:Numeric>(_ lhs:e, _ rhs:(A,e)) -> (A, [e]) {
//  dual(dual((1, lhs)) |^| dual(rhs))
  dual(lhs) |^| dual(rhs)
}

public func |&*|<A:Numeric>(_ lhs:(A,e), _ rhs:(A,e)) -> (A, [e]) {
//  dual(dual(lhs) |^| dual(rhs))
  dual(lhs) |^| dual(rhs)
}

public func |&*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,[e])) -> (A, [e]) {
//  dual(dual(lhs) |^| dual(rhs))
  dual(lhs) |^| dual(rhs)
}

public func |&*|<A:Numeric>(_ lhs:(A,e), _ rhs:(A,[e])) -> (A, [e]) {
    //  dual(dual(lhs) |^| dual(rhs))
  dual(lhs) |^| dual(rhs)
}

public func |&*|<A:Numeric>(_ lhs:(A,[e]), _ rhs:(A,e)) -> (A, [e]) {
    //  dual(dual(lhs) |^| dual(rhs))
  dual(lhs) |^| dual(rhs)
}

public func |&*|<A:Numeric>(_ lhs:[(A,[e])], _ rhs:[(A,[e])]) -> [(A, [e])] {
//  dual(dual(lhs) |^| dual(rhs))
  dual(lhs) |^| dual(rhs)
}
