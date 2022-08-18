
import XCTest
@testable import pgaExperiments


class pgaGeometricNumberTests:XCTestCase {
  
  func testGeometricNumberCreation() {
    let gn = GeometricNumber(e: e(UInt8.max), coefficient: 10.10)
    XCTAssertEqual(gn.e.index,e(UInt8.max).index, "Geometric number \"e\" mismatch")
    XCTAssertEqual(gn.e, e(UInt8.max), "Geometric number \"e\" mismatch")
    XCTAssertEqual(gn.coefficient, 10.10, "Geometric number co-efficient mismatch")
  }
  
  func testGeometricNumberCreationUsingScopedStarOperator() {
    let gn = GeometricNumber(e: e(UInt8.min), coefficient: 10)
    XCTAssertEqual(gn, 10|*|e(UInt8.min) ,"Geometric number \"e\" mismatch")
    XCTAssertEqual(gn, e(UInt8.min)|*|10, "Geometric number \"e\" mismatch")
  }
  
  func testGeometricNumberCreationWithMulAndDivOperators() {
    let gn = GeometricNumber(e: e(UInt8.min), coefficient: 10)
    XCTAssertEqual(gn, 5*2|*|e(UInt8.min) ,"Geometric number \"e\" mismatch")
    XCTAssertEqual(gn, e(UInt8.min)|*|5*2, "Geometric number co-efficient mismatch")
    XCTAssertEqual(gn, e(UInt8.min)|*|10*10/10, "Geometric number \"e\" mismatch")
    XCTAssertEqual(gn, 10*10/10|*|e(UInt8.min) ,"Geometric number \"e\" mismatch")
  }
  
  func testGeometricNumberCreationDescription() {
    let gn = GeometricNumber(e: e(UInt8.min), coefficient: 1.1)
    
    XCTAssertEqual(gn.description, "1.1*e(0)")
    XCTAssertEqual((1.1|*|e(UInt8.max)).description, "1.1*e(255)")
    
    XCTAssertEqual(gn.description, (1.1|*|e(UInt8.min)).description)
    XCTAssertEqual(gn.description, (1.1*1/1|*|e(UInt8.min)).description)
    XCTAssertEqual(gn.description, (e(UInt8.min)|*|1.1*1).description)
    XCTAssertEqual(gn.description, (e(UInt8.min)|*|11/10).description)
  }
}
