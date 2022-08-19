import Foundation


// Domain defines e(i)*e(i) = ?

public enum domains:Float {
  case positive = 1 // e(i)*e(i) = 1
  case negetive = -1 // e(i)*e(i) = -1
  case zero = 0 // e(i)*e(i) =  0; for 0 < i <= 3, Grossman Algebra domain
}

public func domain(type:domains, _ e1:e, _ e2:e) -> Float {
  return domains.zero.rawValue
}

private let d = curry(domain(type:_:_:))(.zero)
public let localDomain = uncurry(d)
//public let equalE = d(e(1))(e(1))
