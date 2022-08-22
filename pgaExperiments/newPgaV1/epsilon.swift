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

internal var e0 = e(0)
internal var e1 = e0 |> set(^\e.index, 1)
//internal var e2 = E0 |> set(^\e.index, 2)
//internal var e3 = E0 |> set(^\e.index, 3)
//internal var e4 = E0 |> set(^\e.index, 4)
