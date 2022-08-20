import XCTest
@testable import pgaExperiments

class pgaBasisElementsTests: XCTestCase {
  let e0 = e(0)
  let e1 = e(1)
  let e2 = e(2)
  let e3 = e(3)
  var g0:GeometricNumber { 1|*|e0 }
  var g1:GeometricNumber { 1.1|*|e1 }
  var g2:GeometricNumber { e2|*|2.2 }
  var g3:GeometricNumber { e3|*|3.3 }
  
  let number = Float.pi
  
  func testBasisElementsInit() {
    let be1 = BasisElements.scalar(number)
    switch be1 {
      case let .scalar(val):
        XCTAssertEqual(number, val)
      case .vectors(_):
        break
    }
    XCTAssertEqual(be1.description, "\(number)")
    
    let be2 = BasisElements.vectors([g1,g2])
    switch be2 {
      case .scalar(_):
        break
      case let .vectors(gns):
        XCTAssertEqual([g1,g2], gns)
        XCTAssertEqual(gns.count, 2)
    }
    XCTAssertEqual(be2.description, "\(g1.coefficient*g2.coefficient)*\(g1.e)\(g2.e)")
  }

//  func testFloatOpFloatOutBasisElement() {
//    let be:BasisElements = number|*|number
//    switch be {
//      case let .scalar(val):
//        XCTAssertEqual(val, number*number)
//      case .vectors(_):
//        break
//    }
//    XCTAssertEqual(be.description, "\(number*number)")
//  }
  
//  func testFloatAddFloatOpFloatAddFloatOutBasisElement() {
//    let be:BasisElements = (number+1)|*|(number+1)
//    switch be {
//      case let .scalar(val):
//        XCTAssertEqual(val, (number+1)*(number+1))
//      case .vectors(_):
//        break
//    }
//    XCTAssertEqual(be.description, "\((number+1)*(number+1))")
//  }
  
//  func testFloatSubFloatOpFloatSubFloatOutBasisElement() {
//    let be:BasisElements = (number-1)|*|(number-1)
//    switch be {
//      case let .scalar(val):
//        XCTAssertEqual(val, (number-1)*(number-1))
//      case .vectors(_):
//        break
//    }
//    XCTAssertEqual(be.description, "\((number-1)*(number-1))")
//  }
  
//  func testFloatMulFloatOpFloatMulFloatOutBasisElement() {
//    let be:BasisElements = (number*2)|*|(number*3)
//    switch be {
//      case let .scalar(val):
//        XCTAssertEqual(val, (number*2)*(number*3))
//      case .vectors(_):
//        break
//    }
//    XCTAssertEqual(be.description, "\((number*2)*(number*3))")
//  }
  
//  func testFloatDivFloatOpFloatDivFloatOutBasisElement() {
//    let be:BasisElements = (number/2)|*|(number/3)
//    switch be {
//      case let .scalar(val):
//        XCTAssertEqual(val, (number/2)*(number/3))
//      case .vectors(_):
//        break
//    }
//    XCTAssertEqual(be.description, "\((number/2)*(number/3))")
//  }

  func testEOpGeometricNumberOutBasisElement() {
    let be1 = e1|*|g2
    switch be1 {
      case .scalar(_):
        break
      case let .vectors(gns):
        print(gns)
        XCTAssertEqual(gns.count, 2)
        XCTAssertEqual(gns.first!, 1|*|e1)
        XCTAssertEqual(gns.first!.description, "1.0*e(1)")
        XCTAssertEqual(gns.last!, 2.2|*|e2)
        XCTAssertEqual(gns.last!.description, "2.2*e(2)")
        XCTAssertEqual(be1.description, "2.2*e(1)e(2)")
        
    }
  }
  
  func testGeometricNumberOpEOutBasisElement() {
    let be1 = g2|*|e1
    switch be1 {
      case .scalar(_):
        break
      case let .vectors(gns):
        print(gns)
        XCTAssertEqual(gns.count, 2)
        XCTAssertNotEqual(gns.first!, 1|*|e1)
        XCTAssertEqual(gns.first!.description, "-1.0*e(1)")
        XCTAssertEqual(gns.last!, 2.2|*|e2)
        XCTAssertEqual(gns.last!.description, "2.2*e(2)")
        XCTAssertEqual(be1.description, "-2.2*e(1)e(2)")
        
    }
  }
}
