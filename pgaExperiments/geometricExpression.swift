import Foundation

public struct GeometricExpression {
  var expression:[(lable:String, number:GeometricNumber)]
}

extension GeometricExpression:CustomStringConvertible {
  public var description: String {
    self.expression.map { (lable:String,number:GeometricNumber) in
      return "\(number.coefficient >= 0 ? lable : "")\(number)"
    }.joined()
  }
}

