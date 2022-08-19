import Foundation

public func curry<A,B,R>(_ f:@escaping (A,B) -> R) -> (A) -> (B) -> R {
  return { a in { b in f(a,b) } }
}

public func curry<A,B,C,R>(_ f:@escaping (A,B,C) -> R) -> (A) -> (B) -> (C) -> R{
  return { a in { b in { c in  f(a,b,c) } } }
}

public func curry<A,B,C,D,R>(_ f:@escaping (A,B,C,D) -> R) -> (A) -> (B) -> (C) -> (D) -> R{
  return { a in { b in { c in  { d in f(a,b,c,d) } } } }
}

public func curry<A,B,C,D,E,R>(_ f:@escaping (A,B,C,D,E) -> R) -> (A) -> (B) -> (C) -> (D) -> (E) -> R{
  return { a in { b in { c in  { d in { e in f(a,b,c,d,e) } } } } }
}

public func uncurry<A,B,R>(_ f:@escaping
(A)->(B)->R) -> (A,B) -> R {
  return { (a:A, b:B) -> R in f(a)(b) }
}

public func uncurry<A,B,C,R>(_ f:@escaping
(A)->(B)->(C)->R) -> (A,B,C) -> R {
  return { (a:A, b:B, c:C) -> R in f(a)(b)(c) }
}

public func uncurry<A,B,C,D,R>(_ f:@escaping
(A)->(B)->(C)->(D)->R) -> (A,B,C,D) -> R {
  return { (a:A, b:B, c:C, d:D) -> R in f(a)(b)(c)(d) }
}
