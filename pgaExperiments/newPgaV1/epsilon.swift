import Foundation

public struct e {
  var index:UInt8
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

extension e:Hashable { }

internal let e0 = 1.0 |^| e(0)
internal let e1 = 1.0 |^| e(1)
internal let e2 = 1.0 |^| e(2)
internal let e3 = 1.0 |^| e(3)
internal let e12 = e1 |^| e2
internal let e21 = e2 |^| e1
internal let e123 = e12 |^| e(3)


