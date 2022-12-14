import Foundation


internal func first<A, B, C>(_ f: @escaping (A) -> C) -> ((A, B)) -> (C, B) {
  return { pair in
    return (f(pair.0), pair.1)
  }
}

internal func second<A,B,C>(_ f:@escaping (B) -> C) -> ((A,B)) -> (A,C) {
  return { pair in
    return (pair.0, f(pair.1))
  }
}

internal func prop<Root,Value>(_ kp:WritableKeyPath<Root,Value>) ->
(@escaping (Value) -> Value) -> (Root) -> Root
{
  return { update in
    return { root in
      var copy = root
      copy[keyPath: kp] = update(copy[keyPath: kp])
      return copy
    }
  }
}

internal func prop<Root, Value>(
  _ kp: WritableKeyPath<Root, Value>,
  _ f: @escaping (Value) -> Value
)
-> (Root) -> Root {
  
  return prop(kp)(f)
}

internal func prop<Root, Value>(
  _ kp: WritableKeyPath<Root, Value>,
  _ value: Value
)
-> (Root) -> Root {
  
  return prop(kp) { _ in value }
}

internal func over<Root, Value>(
  _ setter: (@escaping (Value) -> Value) -> (Root) -> Root,
  _ f: @escaping (Value) -> Value
)
-> (Root) -> Root {
  
  return setter(f)
}

internal func set<Root, Value>(
  _ setter: (@escaping (Value) -> Value) -> (Root) -> Root,
  _ value: Value
)
-> (Root) -> Root {
  
  return over(setter) { _ in value }
}

typealias Setter<S, T, A, B> = (@escaping (A) -> B) -> (S) -> T

internal func over<S, T, A, B>(
  _ setter: Setter<S, T, A, B>,
  _ set: @escaping (A) -> B
)
-> (S) -> T {
  return setter(set)
}

internal func set<S, T, A, B>(
  _ setter: Setter<S, T, A, B>,
  _ value: B
)
-> (S) -> T {
  return over(setter) { _ in value }
}

prefix operator ^

internal prefix func ^ <Root, Value>(kp: WritableKeyPath<Root, Value>)
-> (@escaping (Value) -> Value)
-> (Root) -> Root {
  
  return prop(kp)
}
