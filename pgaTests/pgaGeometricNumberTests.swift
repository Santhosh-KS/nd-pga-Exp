
import XCTest
@testable import pgaExperiments


class pgaGeometricNumberTests:XCTestCase {
  let number = 2*Float.pi
  func testGeometricNumberConstructor() {
    let gn = GeometricNumber(e: e(UInt8.max), coefficient: number)
    XCTAssertEqual(gn.e.index,e(UInt8.max).index)
    XCTAssertEqual(gn.e, e(UInt8.max))
    XCTAssertEqual(gn.coefficient, number)
    XCTAssertEqual(gn.description, "\(number)*e(\(UInt8.max))")
  }
  
  func testFloatGeometricNumber() {
    let gn = GeometricNumber(e: e(UInt8.min), coefficient: number)
    XCTAssertEqual(gn, number|*|e(UInt8.min))
    XCTAssertEqual(gn.description, "\(number)*e(\(UInt8.min))")
  }
  
  func testGeometricNumberFloat() {
    let gn = GeometricNumber(e: e(UInt8.min), coefficient: number)
    XCTAssertEqual(gn, e(UInt8.min)|*|number)
    XCTAssertEqual(gn.description, "\(number)*e(\(UInt8.min))")
  }
  
  func testNormalMultiplicationFloatGeometricNumber() {
    let gn = GeometricNumber(e: e(UInt8.min), coefficient: number*2)
    XCTAssertEqual(gn, number*2|*|e(UInt8.min))
    XCTAssertEqual(gn, e(UInt8.min)|*|number*2)
    XCTAssertEqual(gn.description, "\(number*2)*e(\(UInt8.min))")
  }
  
  func testNormalDivisionFloatGeometricNumber() {
    let gn = GeometricNumber(e: e(UInt8.min), coefficient: number/10)
    XCTAssertEqual(gn, number/10|*|e(UInt8.min))
    XCTAssertEqual(gn, e(UInt8.min)|*|number/10)
    XCTAssertEqual(gn.description, "\(number/10)*e(\(UInt8.min))")
  }
  
  func testNormalAdditionFloatGeometricNumber() {
    let gn = GeometricNumber(e: e(UInt8.min), coefficient: number+number)
    XCTAssertEqual(gn, (number+number)|*|e(UInt8.min))
    XCTAssertEqual(gn, e(UInt8.min)|*|(number+number))
    XCTAssertEqual(gn.description, "\(number+number)*e(\(UInt8.min))")
  }
  
  func testNormalSubstractionFloatGeometricNumber() {
    let gn = GeometricNumber(e: e(UInt8.min), coefficient: number-0.5)
    XCTAssertEqual(gn, (number-0.5)|*|e(UInt8.min))
    XCTAssertEqual(gn, e(UInt8.min)|*|(number-0.5))
    XCTAssertEqual(gn.description, "\(number-0.5)*e(\(UInt8.min))")
  }
  
  func testGeometricNumberCreationWithMulAndDivOperators() {
    let gn = GeometricNumber(e: e(UInt8.min), coefficient: number*2)
    XCTAssertEqual(gn, number*2|*|e(UInt8.min))
    XCTAssertEqual(gn, e(UInt8.min)|*|number*2)
    XCTAssertEqual(gn.description, "\(number*2)*e(\(UInt8.min))")
    
    let gn1 = GeometricNumber(e: e(UInt8.min), coefficient: 10)
    XCTAssertEqual(gn1, e(UInt8.min)|*|10*10/10)
    XCTAssertEqual(gn1, 10*10/10|*|e(UInt8.min))
    XCTAssertEqual(gn1.description, "10.0*e(\(UInt8.min))")
  }
  
  func testDescription() {
    let gn = GeometricNumber(e: e(UInt8.min), coefficient: 1.1)
    
    XCTAssertEqual(gn.description, "1.1*e(0)")
    XCTAssertEqual((1.1|*|e(UInt8.max)).description, "1.1*e(255)")
    
    XCTAssertEqual(gn.description, (1.1|*|e(UInt8.min)).description)
    XCTAssertEqual(gn.description, (1.1*1/1|*|e(UInt8.min)).description)
    XCTAssertEqual(gn.description, (e(UInt8.min)|*|1.1*1).description)
    XCTAssertEqual(gn.description, (e(UInt8.min)|*|11/10).description)
  }
}
