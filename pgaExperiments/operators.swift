import Foundation

precedencegroup eProccessOrder {
  associativity:left
  higherThan: AdditionPrecedence
  lowerThan: MultiplicationPrecedence
}

infix operator |*|:eProccessOrder

public func |*|(_ coeff:Float, _ es:e) -> GeometricNumber {
  GeometricNumber(e: es,coefficient: coeff)
}

public func |*|(_ es:e,_ coeff:Float) -> GeometricNumber {
  GeometricNumber(e: es,coefficient: coeff)
}

public func |*|(_ val:Float, _ g1:GeometricNumber) -> GeometricNumber {
  (val*g1.coefficient)|*|g1.e
}

public func |*|(_ g1:GeometricNumber, _ val:Float) -> GeometricNumber {
  (val*g1.coefficient)|*|g1.e
}

public func |*|(_ lhs:Float,_ rhs:Float) -> BasisElements {
  return .scalar(lhs*rhs)
}

public func |*|(_ e1:e,_ g1:GeometricNumber) -> BasisElements {
  return evaluate((1|*|e1), g1)
}

public func |*|(_ g1:GeometricNumber, _ e1:e) -> BasisElements {
  return evaluate(g1, 1|*|e1)
}

public func |*|(_ e1:e,_ e2:e) -> BasisElements {
  if e1 == e2 {
    return .scalar(localDomain(e1,e2))
  } else {
    return .vectors([GeometricNumber(e1,1),
                     GeometricNumber(e2,1)].sorted(by: <))
  }
}


public func |*|(_ g1:GeometricNumber,_ g2:GeometricNumber) -> BasisElements {
  if g1.e == g2.e {
    return .scalar(localDomain(g1.e,g2.e)*g1.coefficient*g2.coefficient)
  }
  else {
    return .vectors([(g1.coefficient*g2.coefficient)|*|g1.e, (1|*|g2.e)])
  }
}

public func |*|( _ element: BasisElements,_ number:GeometricNumber) -> BasisElements {
  switch element {
    case let .scalar(value):
      return .vectors([GeometricNumber(e: number.e, coefficient: number.coefficient*value)])
    case let .vectors(gns):
      var a = [GeometricNumber]()
      a.append(contentsOf:gns)
      a.append(number)
      return .vectors(a)
  }
}

public func |*|(_ number:GeometricNumber, _ element:BasisElements) -> BasisElements {
  element|*|number
}

public func |*|(_ lhs:Float, _ elem:BasisElements) -> BasisElements {
  switch elem {
    case let .scalar(val):
      return .scalar(val*lhs)
    case let .vectors(numbers):
      guard let fe = numbers.first else { return .scalar(0)}
      var gs = [GeometricNumber]()
      gs.append(fe.coefficient*lhs|*|fe.e)
      gs.append(contentsOf: numbers.dropFirst())
      return .vectors(gs)
  }
}

public func |*|(_ elem:BasisElements, _ rhs:Float) -> BasisElements {
  return rhs|*|elem
}

public func |*|(_ elm1:BasisElements, _ elm2:BasisElements) -> BasisElements {
  switch (elm1, elm2) {
    case let (.scalar(v1), .scalar(v2)):
      return BasisElements.scalar(v1*v2)
    case let (.scalar(v), .vectors(gns)):
      fallthrough
    case let (.vectors(gns), .scalar(v)):
      var ngns = [GeometricNumber]()
      guard let num = gns.first else { return .scalar(v)}
      ngns.append(v|*|num)
      ngns.append(contentsOf: gns.dropFirst())
      return BasisElements.vectors(ngns)
    case let (.vectors(gns1), .vectors(gns2)):
      var ngns = [GeometricNumber]()
        // 10*e(1) * 2*e(2) = 20*e(1)e(2)
        // TODO: Introduce dot and wedge products to complete this
      gns1.forEach { gn1 in
        gns2.forEach { gn2 in
          if gn1.e == gn2.e {
            ngns.append((gn1.coefficient*gn2.coefficient|*|e(0)))
          } else {
            let v = (gn1|*|gn2)
            switch v {
              case let .scalar(val):
                ngns.append(val|*|e(0))
              case let .vectors(lgns):
                ngns.append(contentsOf: lgns)
            }
          }
        }
      }
      return .vectors(ngns)
  }
}


precedencegroup geometricExpressions {
  associativity:left
}

infix operator |+|:geometricExpressions

//public func |+| (_ lhs:Float, _ rhs:Float) -> GeometricNumber {
//  (lhs+rhs)|*|1
//}

public func |+| (_ lhs:Float, _ rhs:Float) -> BasisElements {
  .scalar(lhs+rhs)
}

//public func |+| (_ lhs:Float, _ rhs:GeometricNumber) -> GeometricExpression {
//  (1|*|lhs) |+| rhs
//}
//
//public func |+| (_ lhs:GeometricNumber, _ rhs:Float) -> GeometricExpression {
//  (rhs|*|1) |+| lhs
//}

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


fileprivate let add = uncurry(curry(reduce(with:_:_:_:))(+))
fileprivate let sub = uncurry(curry(reduce(with:_:_:_:))(-))


fileprivate func evaluate(_ g1:GeometricNumber, _ g2:GeometricNumber) -> BasisElements {
  if g1.e == g2.e {
    return .scalar(localDomain(g1.e, g2.e)*(g1.coefficient*g2.coefficient))
  } else if g1.e > g2.e {
      // This flipping of -1 and 1 is important here.
    return .vectors([-1*g2.coefficient|*|g2.e, g1])
  }else {
    return .vectors([g1,g2])
  }
}

fileprivate func reduce(with f:@escaping (Float, Float) -> Float,_ a:Float, _ b:Float, _ e:e ) -> (String, GeometricNumber) {
  let c = f(a,b)
  return (c >= 0 ? "+": "-", c|*|e)
}
