import Foundation

public struct BasisVector {
  let coefficient:Float
  let e:e
}

public extension BasisVector {
  init(_ es:e, _ coeff:Float) {
    e = es
    coefficient = coeff
  }
}

public extension BasisVector {
  init(_ coeff:Float, _ es:e) {
    e = es
    coefficient = coeff
  }
}

extension BasisVector : CustomStringConvertible {
  public var description: String {
    "\(coefficient)*\(e)"
  }
}

extension BasisVector: Equatable, Comparable {
  public static func < (lhs: BasisVector, rhs: BasisVector) -> Bool {
    lhs.e < rhs.e
  }
}

public let basisVector = zip2(with: BasisVector.init(coefficient:e:))
