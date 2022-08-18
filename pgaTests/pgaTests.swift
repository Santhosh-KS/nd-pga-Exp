
import XCTest
@testable import pgaExperiments

class pgaTests:XCTestCase {
  
  func testEpsilonCreation() {
    XCTAssertEqual(e(UInt8.max).index, UInt8.max, "\"e\" values out of bound")
    XCTAssertEqual(e(UInt8.min).index, UInt8.min, "\"e\" values out of bound")
  }
  
  func testEpsilonDescription() {
    XCTAssertEqual(e(UInt8.max).description, "e(\(UInt8.max))", "\"e\" description mismatch")
    XCTAssertEqual(e(UInt8.min).description, "e(\(UInt8.min))", "\"e\" description mismatch")
  }
}
