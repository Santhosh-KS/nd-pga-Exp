
import XCTest
@testable import pgaExperiments

class pgaGeometricNumberWithPlusOperator: XCTestCase {
  func FloatOpFloatOutGeometricNumber() {
    let g1:GeometricNumber = Float(1) |+| Float(2)
//    XCTAssertEqual(|+|2.0, |+|2)
  }
}
