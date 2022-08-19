import Foundation

public enum BasisElements {
  case scalar(Float)
  case vectors([GeometricNumber])
  
//  var grade:Int {
//    switch self {
//      case .scalar(_):
//        return 0
//      case let .vectors(gns):
//        return gns.count
//    }
//  }
}

extension BasisElements: CustomStringConvertible {
  public var description: String {
    switch self {
      case let .scalar(value):
        return "\(value)"
      case let .vectors(gns):
        return "\(gns.map { $0.coefficient }.reduce(1, *))*" +
        gns.map { gn in
          "\(gn.e)"
        }.joined(separator: "")
    }
  }
}
