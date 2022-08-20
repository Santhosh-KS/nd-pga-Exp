//
//  pgaV1UT.swift
//  pgaV1UT
//
//  Created by Santhosh K S on 20/08/22.
//

import XCTest

class pgaV1UT: XCTestCase  {
  
  func testAdditionCommutativeOperations() {
    
    XCTAssertEqual(1 |+| 2,  2 |+| 1)
    XCTAssertEqual((1 |+| 2).description, "3.0*e(0)")
    
    XCTAssertEqual(1 |+| 2 |+| 3, 3 |+| 2 |+| 1)
    XCTAssertEqual(1 |+| 2 |+| 3, 2 |+| 1 |+| 3)
    XCTAssertEqual((1 |+| 2 |+| 3).description, "[6.0*e(0)]")
  }
  
  func testAdditionAssociativityOperations() {
    XCTAssertEqual(1 |+| (2 |+| 3), (1 |+| 2 ) |+| 3)
    XCTAssertEqual((1 |+| 2 |+| 3).description, "[6.0*e(0)]")
  }
  
}
