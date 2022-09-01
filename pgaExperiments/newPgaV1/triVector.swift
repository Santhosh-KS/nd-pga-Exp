import Foundation

import Foundation

public struct TriVector<A:Numeric> {
  var coefficient:A
  private (set) var e:(e,e,e)
}

public extension TriVector {
  init(_ coef:A, _ es:(e,e,e)) {
    coefficient = coef
    e = es
  }
  
  init(_ es:(e,e,e), _ coef:A) {
    coefficient = coef
    e = es
  }
  
  init(coefficient coef:A, withArrayOfE es:[e]) {
    coefficient = coef
    if es.count < 3 {
      e = (es.first!, .init(index: 0), .init(index: 0))
    } else {
      e = (es.first!, es.dropFirst().first!, es.dropFirst().first!)
    }
  }
}

extension TriVector:CustomStringConvertible {
  public var description: String {
    "\(coefficient)*\(e.0)\(e.1)\(e.2)"
  }
}

extension TriVector:Equatable, Comparable {
  public static func < (lhs: TriVector, rhs: TriVector) -> Bool {
    lhs.e < rhs.e
  }
  
  public static func == (lhs: TriVector, rhs: TriVector) -> Bool {
    lhs.e == rhs.e
  }
}


internal let defaultTriVector = e123 |> TriVector.init(coefficient:withArrayOfE:)
