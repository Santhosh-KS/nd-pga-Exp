
import XCTest

final class dualOperationTests: XCTestCase {
  func testDualOfGrade0() {
    XCTAssertEqual(dual(e0).0, 1)
    XCTAssertEqual(dual(e0).1, e0123.1)
    XCTAssertEqual(dual(e11).0, 1)
    XCTAssertEqual(dual(e11).1, e0123.1)
    XCTAssertEqual(dual(e22).0, 1)
    XCTAssertEqual(dual(e22).1, e0123.1)
    XCTAssertEqual(dual(e33).0, 1)
    XCTAssertEqual(dual(e33).1, e0123.1)
    
    XCTAssertEqual(dual(10).0, 10)
    XCTAssertEqual(dual(10).1, e0123.1)
  }
  
  func testOperatorDualOfGrade0() {
    XCTAssertEqual((|!|e0).0, 1)
    XCTAssertEqual((|!|e0).1, e0123.1)
    XCTAssertEqual((|!|e0).0, 1)
    XCTAssertEqual((|!|e0).1, e0123.1)
    XCTAssertEqual((|!|e0).0, 1)
    XCTAssertEqual((|!|e0).1, e0123.1)
    XCTAssertEqual((|!|e0).0, 1)
    XCTAssertEqual((|!|e0).1, e0123.1)
    
    XCTAssertEqual((|!|10).0, 10)
    XCTAssertEqual((|!|10).1, e0123.1)
  }
  
  func testDualOfGrade1() {
    XCTAssertEqual(dual(e1).0, 1)
    XCTAssertEqual(dual(e1).1, e23.1)
    XCTAssertEqual(dual(e2).0, -1)
    XCTAssertEqual(dual(e2).1, e13.1)
    XCTAssertEqual(dual(e3).0, 1)
    XCTAssertEqual(dual(e3).1, e12.1)
  }
  
  func testOperatorDualOfGrade1() {
    XCTAssertEqual((|!|e1).0, 1)
    XCTAssertEqual((|!|e1).1, e23.1)
    XCTAssertEqual((|!|e2).0, -1)
    XCTAssertEqual((|!|e2).1, e13.1)
    XCTAssertEqual((|!|e3).0, 1)
    XCTAssertEqual((|!|e3).1, e12.1)
  }
  
  func testDualOfGrade2() {
    XCTAssertEqual(dual(e12).0, -1)
    XCTAssertEqual(dual(e12).1.first!, e3.1)
    XCTAssertEqual(dual(e21).0, 1)
    XCTAssertEqual(dual(e21).1.first!, e3.1)
    XCTAssertEqual(dual(e13).0, 1)
    XCTAssertEqual(dual(e13).1.first!, e2.1)
    XCTAssertEqual(dual(e31).0, -1)
    XCTAssertEqual(dual(e31).1.first!, e2.1)
    XCTAssertEqual(dual(e23).0, -1)
    XCTAssertEqual(dual(e23).1.first!, e1.1)
    XCTAssertEqual(dual(e32).0, 1)
    XCTAssertEqual(dual(e32).1.first!, e1.1)
  }
  
  func testDualOfGrade3() {
    XCTAssertEqual(dual(e123).0, -1)
    XCTAssertEqual(dual(e123).1, [])
    XCTAssertEqual(dual(e213).0, 1)
    XCTAssertEqual(dual(e213).1, [])
    XCTAssertEqual(dual(e132).0, 1)
    XCTAssertEqual(dual(e132).1, [])
    XCTAssertEqual(dual(e312).0, -1)
    XCTAssertEqual(dual(e312).1, [])
    XCTAssertEqual(dual(e231).0, -1)
    XCTAssertEqual(dual(e231).1, [])
    XCTAssertEqual(dual(e321).0, 1)
    XCTAssertEqual(dual(e321).1, [])
  }
  
}
