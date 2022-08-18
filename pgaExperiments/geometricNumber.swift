import Foundation

public struct GeometricNumber {
  let e:e
  let coefficient:Float
}

extension GeometricNumber : CustomStringConvertible {
  public var description: String {
    "\(coefficient)*\(e)"
  }
}

 extension GeometricNumber: Equatable {}
