import Foundation


// Domain defines e(i)*e(i) = ?

public enum Domain:Float {
  case positive = 1 // e(i)*e(i) = 1
  case negetive = -1 // e(i)*e(i) = -1
  case zero = 0 // e(i)*e(i) =  0; for 0 < i <= 3, Grossman Algebra domain
}

fileprivate var domain = Domain.positive

public var currentDomain: Domain {
  get {
    domain
  }
  set {
    domain = newValue
  }
}
