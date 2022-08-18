public struct e {
  let index:UInt8
}

public extension e {
  init(_ x:UInt8) {
    index = x
  }
}

extension e:Equatable { }

extension e:CustomStringConvertible {
  public var description: String {
    "e(\(self.index))"
  }
}

public enum eType{
  case number(UInt8)
  case e(e)
}

extension eType:CustomStringConvertible {
  public var description: String {
    switch self {
      case let .number(val):
        return String(val)
      case let .e(eVal):
        return "e(\(eVal.index))"
    }
  }
}
