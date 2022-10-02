import XCTest

final class regressiveProductTests: XCTestCase {
  
  func testRegressiveProductOfScalars() {
    let rp_10 = 10 |^*| 10
    XCTAssertEqual(rp_10.0, 0)
    XCTAssertEqual(rp_10.1, [])
    
      //    XCTAssertEqual(rp_10.0, 1)
      //    XCTAssertEqual(rp_10.1, [e(1),e(2),e(3)])
    
    let rp_e0 = e0 |^*| e0
    XCTAssertEqual(rp_e0.0, 0)
    XCTAssertEqual(rp_e0.1, [])
    
      //    XCTAssertEqual(rp_e0.0, 1)
      //    XCTAssertEqual(rp_e0.1, [e(1),e(2),e(3)])
    
    let rp_pi = Float.pi |^*| Float.pi
    XCTAssertEqual(rp_pi.0, 0)
    XCTAssertEqual(rp_pi.1, [])
    
      //    XCTAssertEqual(rp_pi.0, 1)
      //    XCTAssertEqual(rp_pi.1, [e(1),e(2),e(3)])
    
    let rp_e1 = e1 |^*| e1
    XCTAssertEqual(rp_e1.0, 0)
    XCTAssertEqual(rp_e1.1, [])
    
      //    XCTAssertEqual(rp_e1.0, 1)
      //    XCTAssertEqual(rp_e1.1, [e(1), e(2),e(3)])
    
    let rp_e2 = e2 |^*| e2
    XCTAssertEqual(rp_e2.0, 0)
    XCTAssertEqual(rp_e2.1, [])
    
      //    XCTAssertEqual(rp_e2.0, 1)
      //    XCTAssertEqual(rp_e2.1, [e(1), e(2),e(3)])
    
    let rp_e3 = e3 |^*| e3
    XCTAssertEqual(rp_e3.0, 0)
    XCTAssertEqual(rp_e3.1, [])
    
      //    XCTAssertEqual(rp_e3.0, 1)
      //    XCTAssertEqual(rp_e3.1, [e(1), e(2),e(3)])
  }
  
    // TODO: Add more tests for RegressiveProduct of grade2.. etc.
  func testRegressiveProductOfGrade1() {
    let rp_e1_e2 = e1 |^*| e2
    XCTAssertEqual(rp_e1_e2.0, 0)
    XCTAssertEqual(rp_e1_e2.1, [])
  }
  
}
