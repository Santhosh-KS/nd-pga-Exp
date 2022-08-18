import Foundation

precedencegroup eProccessOrder {
  associativity:left
  higherThan: AdditionPrecedence
  lowerThan: MultiplicationPrecedence
}

infix operator |*|:eProccessOrder

public func |*|(_ lhs:Float,_ rhs:Float) -> GeometricNumber {
  return lhs*rhs|*|e(0)
}

public func |*|(_ coeff:Float, _ es:e) -> GeometricNumber {
  GeometricNumber(e: es,coefficient: coeff)
}

public func |*|(_ es:e,_ coeff:Float) -> GeometricNumber {
  GeometricNumber(e: es,coefficient: coeff)
}

precedencegroup geometricExpressions {
  associativity:left
}

fileprivate func reduce(with f:@escaping (Float, Float) -> Float,_ a:Float, _ b:Float, _ e:e ) -> (String, GeometricNumber) {
  let c = f(a,b)
  return (c >= 0 ? "+": "-", c|*|e)
}

fileprivate let add = uncurry(curry(reduce(with:_:_:_:))(+))
fileprivate let sub = uncurry(curry(reduce(with:_:_:_:))(-))

infix operator |+|:geometricExpressions

public func |+| (_ lhs:Float, _ rhs:Float) -> GeometricNumber {
  (lhs+rhs)|*|1
}

public func |+| (_ lhs:Float, _ rhs:GeometricNumber) -> GeometricExpression {
  (1|*|lhs) |+| rhs
}

public func |+| (_ lhs:GeometricNumber, _ rhs:Float) -> GeometricExpression {
  (rhs|*|1) |+| lhs
}

public func |+| (_ lhs:GeometricNumber, _ rhs:GeometricNumber) -> GeometricExpression {
  var exp = [(String, GeometricNumber)]()
  if lhs.e.index == rhs.e.index {
    exp.append(add(lhs.coefficient, rhs.coefficient, lhs.e))
  } else {
    exp.append(add(lhs.coefficient, 0, lhs.e))
    exp.append(add(0, rhs.coefficient, rhs.e))
  }
  return GeometricExpression(expression: exp)
}

public func |+| (_ lhs:GeometricExpression, _ rhs:GeometricNumber) -> GeometricExpression {
  var exp = [(String, GeometricNumber)]()
  var found:Bool = false
  lhs.expression.forEach { (_, gn:GeometricNumber) in
    if gn.e.index == rhs.e.index {
      exp.append(add(gn.coefficient, rhs.coefficient, gn.e))
      found.toggle()
    }
    else {
      exp.append(add(gn.coefficient, 0, gn.e))
    }
  }
  if !found {
    exp.append(add(0,rhs.coefficient, rhs.e))
  }
  return GeometricExpression(expression: exp)
}

public func |+| (_ lhs:GeometricNumber, _ rhs:GeometricExpression) -> GeometricExpression {
  return rhs |+| lhs
}

public func |+| (_ lhs:GeometricExpression, _ rhs:GeometricExpression) -> GeometricExpression {
  var exp = [(String, GeometricNumber)]()

  rhs.expression.forEach { (_, rgn:GeometricNumber) in
    var lfound:Bool = false
    lhs.expression.forEach { (_, lgn: GeometricNumber) in
      if lgn.e.index == rgn.e.index {
        exp.append(add(lgn.coefficient,rgn.coefficient,lgn.e))
        lfound = true
      }
    }
    if (!lfound) {
      exp.append(add(0,rgn.coefficient,rgn.e))
    }
  }
  return GeometricExpression(expression: exp)
}

infix operator |-|:geometricExpressions

public func |-| (_ lhs:GeometricNumber, _ rhs:GeometricNumber) -> GeometricExpression {
  var exp = [(String, GeometricNumber)]()
  if lhs.e.index == rhs.e.index {
    exp.append(sub( lhs.coefficient, rhs.coefficient, lhs.e))
  } else {
    exp.append(sub(lhs.coefficient, 0, lhs.e))
    exp.append(sub(0, rhs.coefficient, rhs.e))
  }
  return GeometricExpression(expression: exp)
}

public func |-| (_ lhs:GeometricExpression, _ rhs:GeometricNumber) -> GeometricExpression {
  var exp = [(String, GeometricNumber)]()
  var found:Bool = false
  lhs.expression.forEach { (_, gn:GeometricNumber) in
    if gn.e.index == rhs.e.index {
      exp.append(sub(gn.coefficient, rhs.coefficient, gn.e))
      found.toggle()
    }
    else {
      exp.append(sub(gn.coefficient, 0, gn.e))
    }
  }
  if !found {
    exp.append(sub(0,rhs.coefficient, rhs.e))
  }
  return GeometricExpression(expression: exp)
}

public func |-| (_ lhs:GeometricNumber, _ rhs:GeometricExpression) -> GeometricExpression {
  return rhs |-| lhs
}

public func |-| (_ lhs:GeometricExpression, _ rhs:GeometricExpression) -> GeometricExpression {
  var exp = [(String, GeometricNumber)]()
  
  rhs.expression.forEach { (_, rgn:GeometricNumber) in
    var lfound:Bool = false
    lhs.expression.forEach { (_, lgn: GeometricNumber) in
      if lgn.e.index == rgn.e.index {
        exp.append(sub(lgn.coefficient,rgn.coefficient,lgn.e))
        lfound = true
      }
    }
    if (!lfound) {
      exp.append(sub(0,rgn.coefficient,rgn.e))
    }
  }
  return GeometricExpression(expression: exp)
}

