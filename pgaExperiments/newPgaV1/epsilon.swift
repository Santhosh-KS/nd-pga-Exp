import Foundation

public struct e {
  let index:UInt8
}

public extension e {
  init(_ x:UInt8) {
    index = x
  }
}

extension e:Equatable, Comparable {
  public static func < (lhs: e, rhs: e) -> Bool {
    lhs.index < rhs.index
  }
}

extension e:CustomStringConvertible {
  public var description: String {
    "e(\(self.index))"
  }
}
