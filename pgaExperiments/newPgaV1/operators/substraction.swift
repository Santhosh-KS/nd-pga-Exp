import Foundation

infix operator |-|:additionEvaluation

public func |-| (_ lhs:Float, _ rhs:Float)  -> (Float, e) {
  (lhs-rhs, e0)
}

public func |-| (_ lhs:[Float], _ rhs:[Float])  -> [(Float, e)] {
  zip2(with: |-|)(lhs, rhs)
}

public func |-| (_ lhs:Float, _ rhs:e)  -> [(Float, e)] {
  if rhs.index == 0 {
    return [(lhs,rhs)]
  }
  return [(lhs, e0), (1, rhs)]
}

public func |-| (_ lhs:[Float], _ rhs:[e]) -> [(Float,e)] {
  zip2(with: |-|)(lhs, rhs) |> flatmap
}

public func |-| (_ lhs:e, _ rhs:Float)  -> [(Float, e)] {
  rhs |-| lhs
}

public func |-| (_ lhs:[e], _ rhs:[Float])  -> [(Float, e)] {
  rhs |-| lhs
}

public func |-| (_ lhs:e, _ rhs:e)  -> [(Float, e)] {
  [(1,lhs), (1,rhs)]
}

public func |-| (_ lhs:[e], _ rhs:[e])  -> [(Float, e)] {
  zip2(with: |-|)(lhs, rhs) |> flatmap
}

public func |-| (_ lhs:Float, _ rhs:(Float, e)) -> [(Float, e)] {
  if rhs.1.index == 0  {
    return [(lhs-rhs.0, e0)]
  }
  return [(lhs, e0), rhs]
}

public func |-| (_ lhs:[Float], _ rhs:[(Float, e)]) -> [(Float, e)] {
  zip2(with: |-|)(lhs, rhs) |> flatmap
}

public func |-| (_ lhs:(Float, e), _ rhs:Float) -> [(Float, e)] {
  rhs |-| lhs
}

public func |-| (_ lhs:[(Float, e)], _ rhs:[Float]) -> [(Float, e)] {
  zip2(with: |-|)(lhs, rhs) |> flatmap
}

public func |-| (_ lhs:(Float,e), _ rhs:(Float,e)) -> [(Float,e)] {
  if lhs.1 == rhs.1 {
    return [(lhs.0-rhs.0, lhs.1)]
  }
  return [lhs, rhs].sorted(by: <)
}

public func |-| (_ lhs:[(Float,e)], _ rhs:[(Float,e)])  -> [(Float, e)] {
  zip2(with: |-|)(lhs, rhs) |> flatmap
}

public func |-| (_ lhs:Float, _ rhs:[(Float,e)]) -> [(Float,e)] {
  rhs.map { (first:Float, second:e) -> (Float,e) in
    if second.index == 0 {
      return (first-lhs, second)
    }
    return (first, second)
  }
}

public func |-| (_ lhs:[Float], _ rhs:[[(Float,e)]]) -> [(Float,e)] {
  zip2(with: |-|)(lhs, rhs) |> flatmap
}

public func |-| (_ lhs:[(Float,e)], _ rhs:Float) -> [(Float,e)] {
  rhs |-| lhs
}

public func |-| (_ lhs:[[(Float,e)]], _ rhs:[Float]) -> [(Float,e)] {
  rhs |-| lhs
}

public func |-| (_ lhs:[(Float,e)], _ rhs:(Float,e)) -> [(Float,e)] {
  lhs.map { (first:Float, second:e) -> (Float, e) in
    if second == rhs.1 {
      return (first-rhs.0, second)
    }
    return (first,second)
  }
}

public func |-| (_ lhs:[[(Float,e)]], _ rhs:[(Float,e)]) -> [(Float,e)] {
  zip2(with: |-|)(lhs, rhs) |> flatmap
}

