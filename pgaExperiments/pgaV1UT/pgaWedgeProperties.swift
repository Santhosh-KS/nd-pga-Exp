import XCTest

class pgaWedgeProperties: XCTestCase {
  
  // Test Wedge Operation Properties
  //  Property-1: Wedge product between a scalar and a vector
  func testWedgeProductBetweenAScalarAndAVector() {
    let scalar = 10
    let vector = (20, e(1))
    
    let result1 = scalar |^| vector
    let result2 = vector |^| scalar
    
    XCTAssertEqual(result1.0, result2.0)
    XCTAssertEqual(result1.1, result1.1)
  }
  
  // Property-2: Wedge product between scalars {
  func testWedgeProductBetweenTwoScalars() {
    let scalar1 = -10
    let scalar2 = 20
    
    let result1 = scalar1 |^| scalar2
    let result2 = scalar2 |^| scalar1
    
    XCTAssertEqual(result1, result2)
  }
  
  // Property-3: Scalar factorization for the wedge product.
  func testScalarFactorizationOfTwoVectors() {
    let result1 = (10, e(1)) |^| e(2)
    let result2 = e(1) |^| (10, e(2))
    
    XCTAssertEqual(result1.0, 10*1)
    XCTAssertEqual(result1.1, [e(1), e(2)])
    
    XCTAssertEqual(result1.0, result2.0)
    XCTAssertEqual(result1.1, result2.1)
  }
  
  // Property-4 Distributive laws for the wedge product.
  func testDistributiveLaw() {
    let a = e(1)
    let b = 5
    let c = 10
    
    let result = a |^| (b+c)
    let result1 = (a |^| b) |+| (a |^| c)
    XCTAssertEqual(result.0, b+c)
    XCTAssertEqual(result1.first!.0, b+c)
    
    XCTAssertEqual(result.1, e(1))
    XCTAssertEqual(result1.first!.1, e(1))
    
    let result2 = (b+c) |^| a
    let result3 = (b |^| a) |+| (c |^| a)
    XCTAssertEqual(result2.0, b+c)
    XCTAssertEqual(result3.first!.0, b+c)
    
    XCTAssertEqual(result2.1, e(1))
    XCTAssertEqual(result3.first!.1, e(1))
  }
  
  // Property-5 Associative law for the wedge product.
  func testAssociativeLaw() {
      // (a |^| b) |^| c == a |^| (b |^| c)
    let a = e(1)
    let b = e(2)
    let c = e(3)
    let ab = a |^| b
    let bc = b |^| c
    
    let result1 = ab |^| c
    let result2 = a |^| bc
    
    XCTAssertEqual(result1, [e(1), e(2), e(3)])
    XCTAssertEqual(result2, [e(1), e(2), e(3)])
    
    let a1 = (10, a)
    let b1 = (20, b)
    let c1 = (30, c)
    
    let result3 = (a1 |^| b1) |^| c1
    let result4 = a1 |^| (b1 |^| c1)
    
    XCTAssertEqual(result3.1, [e(1), e(2), e(3)])
    XCTAssertEqual(result4.1, [e(1), e(2), e(3)])
  }
  
  // Anticommutative property
  // (a+b)^(a+b) = a^a + b^a + a^b + b^b = 0
  // a^a = 0 and b^b = 0,
  // a^b = -b^a
//  func testAntiCommutativity() {
//    let a = e(1)
//    let b = e(2)
//    
//    let c:(Float, e) = a |+| b
//    
//    let result:[(Float, [e])] = c |^| c
//    
//    XCTAssertEqual(result.count, 2)
//    XCTAssertEqual(result.first!.1, [e(1), e(2)])
//  }
}
