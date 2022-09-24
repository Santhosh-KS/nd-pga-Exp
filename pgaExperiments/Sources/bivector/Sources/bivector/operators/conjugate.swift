import Foundation

public func conjugate<A:Numeric>(_ val:A) -> A {
  val
}

public func conjugate<A:Numeric>(_ vec:(A,[e])) -> (A,[e]) {
  vec.1 == [e(0)] ? vec : ((1 |*| vec).1.isEmpty ? (vec.0, []) : (-1*vec.0, vec.1))
}

public func conjugate<A:Numeric>(_ vec:(A,e)) -> (A,[e]) {
  conjugate((vec.0, [vec.1]))
}

public func conjugate<A:Numeric>(_ vec:e) -> (A,[e]) {
  conjugate((1, vec))
}

public func conjugate<A:Numeric>(_ mvec:[e]) -> (A,[e]) {
  conjugate((1, mvec))
}

public func conjugate<A:Numeric>(_ mvecs:[(A,[e])]) -> [(A,[e])] {
  mvecs.map(conjugate)
}
