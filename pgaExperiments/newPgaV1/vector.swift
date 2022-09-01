
import Foundation

import Foundation

public struct Vector<A:Numeric> {
  var coefficient:A
  private (set) var e:e
}

public extension Vector {
  init(_ coef:A, _ E:e) {
    coefficient = coef
    e = E
  }
  
  init(_ E:e, _ coef:A) {
    coefficient = coef
    e = E
  }
  
  init(coefficient coef:A, withArrayOfE es:[e]) {
    coefficient = coef
    if es.isEmpty {
      e = .init(index:0)
    } else {
      e = es.first!
    }
  }
}

extension Vector:CustomStringConvertible {
  public var description: String {
    "\(coefficient)*\(e)"
  }
}

extension Vector:Equatable, Comparable {
  public static func < (lhs: Vector, rhs: Vector) -> Bool {
    lhs.e < rhs.e
  }
  
  public static func == (lhs: Vector, rhs: Vector) -> Bool {
    lhs.e == rhs.e
  }
}

internal let defaultVector = e1 |> Vector.init(coefficient:e:)

