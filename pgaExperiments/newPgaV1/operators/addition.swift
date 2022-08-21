import Foundation

precedencegroup geometricExpressions {
  associativity:left
}

infix operator |+|:geometricExpressions

public func |+| (_ lhs:Float, _ rhs:Float)  -> (Float, e) {
   (lhs+rhs, e(0))
}

public func |+| (_ lhs:[Float], _ rhs:[Float])  -> [(Float, e)] {
  zip2(with: |+|)(lhs, rhs)
}

public func |+| (_ lhs:Float, _ rhs:e)  -> [(Float, e)] {
  if rhs.index == 0 {
    return [(lhs,rhs)]
  }
  return [(lhs,e(0)), (1, rhs)]
}

public func |+| (_ lhs:[Float], _ rhs:[e]) -> [(Float,e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+| (_ lhs:e, _ rhs:Float)  -> [(Float, e)] {
  rhs |+| lhs
}

public func |+| (_ lhs:[e], _ rhs:[Float])  -> [(Float, e)] {
  rhs |+| lhs
}

public func |+| (_ lhs:e, _ rhs:e)  -> [(Float, e)] {
  [(1,lhs), (1,rhs)]
}

public func |+| (_ lhs:[e], _ rhs:[e])  -> [(Float, e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+| (_ lhs:Float, _ rhs:(Float, e)) -> [(Float, e)] {
  if rhs.1.index == 0  {
    return [(lhs+rhs.0, e(0))]
  }
  return [(lhs, e(0)), rhs]
}

public func |+| (_ lhs:[Float], _ rhs:[(Float, e)]) -> [(Float, e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+| (_ lhs:(Float, e), _ rhs:Float) -> [(Float, e)] {
  rhs |+| lhs
}

public func |+| (_ lhs:[(Float, e)], _ rhs:[Float]) -> [(Float, e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+| (_ lhs:(Float,e), _ rhs:(Float,e)) -> [(Float,e)] {
  if lhs.1 == rhs.1 {
    return [(lhs.0+rhs.0, lhs.1)]
  }
  return [lhs, rhs].sorted(by: <)
}

public func |+| (_ lhs:[(Float,e)], _ rhs:[(Float,e)])  -> [(Float, e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+| (_ lhs:Float, _ rhs:[(Float,e)]) -> [(Float,e)] {
  rhs.map { (first:Float, second:e) -> (Float,e) in
    if second.index == 0 {
      return (first+lhs, second)
    }
    return (first, second)
  }
}

public func |+| (_ lhs:[Float], _ rhs:[[(Float,e)]]) -> [(Float,e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

public func |+| (_ lhs:[(Float,e)], _ rhs:Float) -> [(Float,e)] {
  rhs |+| lhs
}

public func |+| (_ lhs:[[(Float,e)]], _ rhs:[Float]) -> [(Float,e)] {
  rhs |+| lhs
}

public func |+| (_ lhs:[(Float,e)], _ rhs:(Float,e)) -> [(Float,e)] {
  lhs.map { (first:Float, second:e) -> (Float, e) in
    if second == rhs.1 {
      return (first+rhs.0, second)
    }
    return (first,second)
  }
}

public func |+| (_ lhs:[[(Float,e)]], _ rhs:[(Float,e)]) -> [(Float,e)] {
  zip2(with: |+|)(lhs, rhs) |> flatmap
}

/*
public func |+| (_ lhs:[BasisVector], _ rhs:BasisVector) -> [BasisVector] {
  lhs.map { bv in
    if bv.e == rhs.e {
      return BasisVector(bv.coefficient+rhs.coefficient, bv.e)
    }
    return bv
  }
}


public func |+| (_ lhs:BasisVector, _ rhs:[BasisVector]) -> [BasisVector] {
  rhs |+| lhs
}

public func |+| (_ lhs:[BasisVector], _ rhs:[BasisVector]) -> [BasisVector] {
  var retVals = [BasisVector]()
  lhs.forEach { lgn in
    rhs.forEach { rgn in
      retVals.append(contentsOf: lgn |+| rgn)
    }
  }
  return retVals.sorted(by: <)
}


public func |+| (_ lhs:e, _ rhs:e) -> [BasisVector] {
  if lhs == rhs {
    return [BasisVector(lhs, 2)].sorted(by: <)
  }
  return [BasisVector(lhs,1), BasisVector(rhs,1)].sorted(by: <)
}


public func |+|(_ lhs:Float, _ rhs:Float)  -> BasisVector {
  BasisVector(e(0), lhs+rhs)
}

public func |+| (_ lhs:Float, _ rhs:BasisVector) -> [BasisVector] {
  if rhs.e.index == 0 {
    return [BasisVector(e(0), lhs+rhs.coefficient)].sorted(by: <)
  }
  return [BasisVector(e(0), lhs), rhs].sorted(by: <)
}

public func |+| (_ lhs:BasisVector, _ rhs:Float) -> [BasisVector] {
  if lhs.e.index == 0 {
    return [BasisVector(e(0), rhs+lhs.coefficient)].sorted(by: <)
  }
  return [BasisVector(e(0), rhs), lhs].sorted(by: <)
}


public func |+| (_ lhs:BasisVector, _ rhs:BasisVector) -> [BasisVector] {
  if lhs.e == rhs.e {
    return [BasisVector(lhs.e, rhs.coefficient+lhs.coefficient)].sorted(by: <)
  }
  return [lhs, rhs].sorted(by: <)
}
public func |+| (_ lhs:[BasisVector], _ rhs:Float) -> [BasisVector] {
  rhs |+| lhs
}

public func |+| (_ lhs:Float, _ rhs:[BasisVector]) -> [BasisVector] {
  rhs.map { bv in
    if (bv.e.index == 0) {
      return BasisVector(coefficient: bv.coefficient+lhs, e: bv.e)
    }
    return bv
  }
}
*/
