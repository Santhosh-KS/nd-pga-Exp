import Foundation

import Foundation

public struct BiVector {
  var coefficient:Float
  var e:(e,e)
}

public extension BiVector {
  init(_ coef:Float, _ es:(e,e)) {
    coefficient = coef
    e = es
  }
  
  init(_ es:(e,e), _ coef:Float) {
    coefficient = coef
    e = es
  }
}

extension BiVector:CustomStringConvertible {
  public var description: String {
    "\(coefficient)*\(e.0)\(e.1)"
  }
}

extension BiVector:Equatable, Comparable {
  public static func < (lhs: BiVector, rhs: BiVector) -> Bool {
    lhs.e < rhs.e
  }
  
  public static func == (lhs: BiVector, rhs: BiVector) -> Bool {
    lhs.e == rhs.e
  }
}

public let biVector = zip2(with: BiVector.init(coefficient:e:))
