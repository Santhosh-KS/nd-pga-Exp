import XCTest

final class bivectorTests: XCTestCase  {
  
  func testScalarProducts() {
    XCTAssertEqual(10 ||| 10, 10*10)
    XCTAssertEqual(10 |*| 10, 10|||10)
    XCTAssertEqual(10 |^| 10, 0)
    
    XCTAssertEqual(5 ||| 7, 7*5)
    XCTAssertEqual(7 |*| 5, 5|||7)
    XCTAssertEqual(7 |^| 5, 0)
  }
  
  func testArrayOfScalarProducts() {
    XCTAssertEqual([10] ||| [10], 10*10)
    XCTAssertEqual([10] |*| [10], [10]|||[10])
    XCTAssertEqual([10] |^| [10], 0)
    
    XCTAssertEqual([5] ||| [7], 7*5)
    XCTAssertEqual([7] |*| [5], [5]|||[7])
    XCTAssertEqual([7] |^| [5], 0)
    
    XCTAssertEqual([1,2,3,4] ||| [5,6,7,8,9], 1*2*3*4*5*6*7*8*9)
    XCTAssertEqual([1,2,3,4] ||| [5,6,7,8,9], [1,2,3,4,5,6,7,8,9].reduce(1, *))
    
    XCTAssertEqual([1,2,3,4] |*| [5,6,7,8,9], [1,2,3,4]|||[5,6,7,8,9])
    XCTAssertEqual([1,2,3,4] |^| [5,6,7,8,9], 0)
  }
  
}
