import Foundation

public struct GeometricNumber {
  let e:e
  let coefficient:Float
}

public extension GeometricNumber {
  init(_ es:e, _ coeff:Float) {
    e = es
    coefficient = coeff
  }
}

extension GeometricNumber : CustomStringConvertible {
  public var description: String {
    "\(coefficient)*\(e)"
  }
}

extension GeometricNumber: Equatable, Comparable {
  public static func < (lhs: GeometricNumber, rhs: GeometricNumber) -> Bool {
    lhs.e < rhs.e
  }
}

