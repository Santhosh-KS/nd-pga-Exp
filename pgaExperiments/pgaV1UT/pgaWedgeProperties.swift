import XCTest

class pgaWedgeProperties: XCTestCase {
    // [10,20] |^| [(1,e(1)),(2,e(2))] = [(10, e(1)), (40, e(2))]
    // [e(1),e(2)] |^| e(3) = [e(1), e(2), e(3)]
    // [e(1),e(2)] |^| e(2) = []
    // e(1) |^| (2, e(2)) = (2, [e(1),e(2)])
    // [e(1), e(1)] |^| [(2, e(2)),(2, e(2))] = [(2, [e(1),e(2)]), (2, [e(1),e(2)])]
    // e(1) |^| e(1) = []
    // e(1) |^| e(2) = [e(1), e(2)]
    // [e(1), e(1)] |^| [e(2), e(2)] = [[e(1), e(2)], [e(1), e(2)]]
    // (10, e(1)) |^| (20, e(2)) = (200, [e(1),e(2)])
    // [(10, e(1)), (10, e(1))] |^| [(20, e(2)), (20, e(2))] = [(200, [e(1),e(2)]), (200, [e(1),e(2)])]
    // (10, [e(1),e(2)]) |^| (10, [e(1),e(2)])
    // (10, e(1)^e(2)) |^| (5, e(1))
  // Test Wedge Operation Properties
  //  Property-1: Wedge product between a scalar and a vector
  func testWedgeProductBetweenAScalarAndAVector() {
    let scalar = 10
    let vector = (20, e(1))
    
    let result1 = scalar |^| vector
    let result2 = vector |^| scalar
    
    XCTAssertEqual(result1.0, result2.0)
    XCTAssertEqual(result1.1, result1.1)
    
    let scalars = [10]
    let vectors = [(20, e(1))]
    
    let result3 = scalars |^| vectors
    let result4 = vectors |^| scalars
    
    XCTAssertEqual(result3.count, 1)
    XCTAssertEqual(result4.count, 1)
    
    XCTAssertEqual(result3.first!.0, 200)
    
    XCTAssertEqual(result3.first!.0, result4.first!.0)
    XCTAssertEqual(result3.first!.1, result4.first!.1)
    
    
    let scalars1 = [10,11]
    let vectors1 = [(20, e(1)), (30, e(2))]
    
    let result5 = scalars1 |^| vectors1
    let result6 = vectors1 |^| scalars1
    
    XCTAssertEqual(result5.count, 2)
    XCTAssertEqual(result6.count, 2)
    
    XCTAssertEqual(result5.first!.0, 200)
    XCTAssertEqual(result5.first!.1, e(1))
    XCTAssertEqual(result5.last!.0, 330)
    XCTAssertEqual(result5.last!.1, e(2))
    
    XCTAssertEqual(result6.first!.0, 200)
    XCTAssertEqual(result6.first!.1, e(1))
    XCTAssertEqual(result6.last!.0, 330)
    XCTAssertEqual(result6.last!.1, e(2))
    
    XCTAssertEqual(result5.first!.0, result6.first!.0)
    XCTAssertEqual(result5.first!.1, result6.first!.1)
    
  }
  
  // Property-2: Wedge product between scalars {
  func testWedgeProductBetweenTwoScalars() {
    let scalar1 = -10
    let scalar2 = 20
    
    let result1 = scalar1 |^| scalar2
    let result2 = scalar2 |^| scalar1
    
    XCTAssertEqual(result1, result2)
    
    let scalars1 = [-10]
    let scalars2 = [20]
    
    let result3 = scalars1 |^| scalars2
    let result4 = scalars2 |^| scalars1
    
    XCTAssertEqual(result3, result4)
    
    let scalars3 = Array(repeating: 10, count: 5)
    let scalars4 = Array(repeating: 20, count: 5)
    
    let result5 = scalars3 |^| scalars4
    let result6 = scalars4 |^| scalars3
    
    XCTAssertEqual(result5, result6)
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
    
    let result = a |^| (b|+|c)
    let result1 = (a |^| b) |+| (a |^| c)
    
    XCTAssertEqual(result.0, b+c)
    
    XCTAssertEqual(result1.count,  1)
    XCTAssertEqual(result1.first!.0, b+c)
    
    XCTAssertEqual(result.1, e(1))
    XCTAssertEqual(result1.first!.1, e(1))
    
    let result2 = (b+c) |^| a
    let result3 = (b |^| a) |+| (c |^| a)
    XCTAssertEqual(result2.0, b+c)
    
    XCTAssertEqual(result3.count,  1)
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
  func testAntiCommutativity() {
    let a = e1
    let b = e2

    let c = a |+| b

    let result = c |^| c
    let resultEx = (a |+| b) |^| (a |+| b)

    XCTAssertEqual(result.count, 2)
    XCTAssertEqual(result.first!.1, [e(1), e(2)])
    XCTAssertEqual(result.last!.1 , [e(2), e(1)])
    
    XCTAssertNotEqual(result.first!.1, [])
    XCTAssertNotEqual(result.last!.1, [])
    
    XCTAssertEqual(resultEx.count, 2)
    XCTAssertEqual(resultEx.first!.1, [e(1), e(2)])
    XCTAssertEqual(resultEx.last!.1 , [e(2), e(1)])
    
    XCTAssertNotEqual(resultEx.first!.1, [])
    XCTAssertNotEqual(resultEx.last!.1, [])
    
    let e1 = e1
    let e2 = e2
    
    let result1 = (e1 |+| e2) |^| (e1 |+| e2)
    
    XCTAssertEqual(result1.count, 2)
    
    XCTAssertEqual(result1.first!.1, [e(1), e(2)])
    XCTAssertEqual(result1.last!.1 , [e(2), e(1)])
    
    XCTAssertNotEqual(result1.first!.1, [])
    XCTAssertNotEqual(result1.last!.1, [])
    
    let e1s = [e1]
    let e2s = [e2]

    let result2 = (e1s |+| e2s) |^| (e1s |+| e2s)

    XCTAssertEqual(result2.count, 2)

    XCTAssertEqual(result2.first!.1, [e(1), e(2)])
    XCTAssertEqual(result2.last!.1 , [e(2), e(1)])

    XCTAssertNotEqual(result2.first!.1, [])
    XCTAssertNotEqual(result2.last!.1, [])
  }
  
  func testabc() {
    let a = (10, e(1)) |+| (20, e(2)) |+| (30, e(3))
    
    let result = a + a
    
    XCTAssertEqual(result.count, 2)
  }
}
