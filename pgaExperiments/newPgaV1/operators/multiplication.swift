import Foundation

precedencegroup geometricVectorProcessingOrder {
  associativity:left
//  higherThan: AdditionPrecedence
//  lowerThan: MultiplicationPrecedence
}


// a  *  b = a . b + a ^ b -- (1)
// a |*| b = a|||b + a|^|b --> Notation Convention equivalent of eq(1)

infix operator |*|:geometricVectorProcessingOrder
infix operator |||:geometricVectorProcessingOrder
infix operator |^|:geometricVectorProcessingOrder

func ||| (_ lhs:BasisVector, _ rhs:BasisVector) -> BiVector {
  if lhs.e > rhs.e {
    return BiVector(-1*lhs.coefficient*rhs.coefficient, (rhs.e, lhs.e))
  }
  return BiVector(1*lhs.coefficient*rhs.coefficient, (lhs.e, rhs.e))
}

func ||| (_ lhs:[BasisVector], _ rhs:[BasisVector]) -> [BiVector] {
  zip2(with: |||) (lhs, rhs)
}


func |^| (_ lhs:BasisVector, _ rhs:BasisVector) -> BiVector {
  if (lhs.e == rhs.e) {
    // example: e(1) ^ e(1) = 0
    // here we are assuming Grossmann algebra
    return BiVector(0, (lhs.e, rhs.e))
  }
  if lhs.e > rhs.e {
    return BiVector(-1*lhs.coefficient*rhs.coefficient, (rhs.e, lhs.e))
  }
  return BiVector(1*lhs.coefficient*rhs.coefficient, (lhs.e, rhs.e))
}


func |^| (_ lhs:[BasisVector], _ rhs:[BasisVector]) -> [BiVector] {
  zip2(with: |^|) (lhs, rhs)
}
