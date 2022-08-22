import Foundation

public struct BasisVector {
  var coefficient:Float
  var e:e
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

internal let basisVector = zip2(with: BasisVector.init(coefficient:e:))

internal var bv0 = BasisVector(coefficient: 1, e: e(0))
internal var bv1 = bv0 |> set(^\.e.index, 1)
//internal var bv2 = bv0 |> set(^\.e.index, 2)
//internal var bv3 = bv0 |> set(^\.e.index, 3)
//internal var bv4 = bv0 |> set(^\.e.index, 4)
//internal var bv5 = bv0 |> set(^\.e.index, 5)
