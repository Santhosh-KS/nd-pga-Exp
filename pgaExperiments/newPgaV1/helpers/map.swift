import Foundation

public func map<A,B>(_ f:@escaping (A)->B) -> ([A]) -> [B] {
  return { xs in
    xs.map(f)
  }
}
//
//public func map<A,B,R>(_ f:@escaping (A) -> B) -> (epsilon<R,A>) -> epsilon<R,B> {
////  return { r2a in }
//  return { r2a in
//    return epsilon { r in
//      f(r2a.apply(r))
//    }
//  }
//}
