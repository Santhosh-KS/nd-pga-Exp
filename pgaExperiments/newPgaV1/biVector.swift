import Foundation

import Foundation

public struct BiVector<A:Numeric> {
  var coefficient:A
  private (set) var e:(e,e)
}

public extension BiVector {
  init(_ coef:A, _ es:(e,e)) {
    coefficient = coef
    e = es
  }
  
  init(_ es:(e,e), _ coef:A) {
    coefficient = coef
    e = es
  }
  
  init(coefficient coef:A, withArrayOfE es:[e]) {
    coefficient = coef
    if es.count < 2 {
      e = (es.first!, .init(index: 0))
    } else {
      e = (es.first!, es.dropFirst().first!)
    }
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


internal let defaultBivector = e12 |> BiVector.init(coefficient:withArrayOfE:)


//public let biVectors = zip2(with: BiVector<Float>.init(coefficient:withArrayOfE:))
//let bvs = biVectors(
//  [11,12,13],
//  [[e(1),e(2)],[e(2),e(3)]]
//)
