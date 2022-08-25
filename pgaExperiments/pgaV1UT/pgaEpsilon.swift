//
//  pgaEpsilon.swift
//  pgaV1UT
//
//  Created by Santhosh K S on 23/08/22.
//

import XCTest

class pgaEpsilon: XCTestCase {
  
  let epsilons = [UInt8.min, UInt8.max] |> map(e.init(index:))
  var e0:e { e(0) }
  var e1:e { e(index:1) }
  
  func testEpsilonNormalCreation() {
    XCTAssertEqual(e(0), e0)
    XCTAssertEqual(e(1), e1)
  }
  
  // Test All possible indexes
  func testEpsilonCreationUsingArray() {
    let indexes = Array(UInt8.min...UInt8.max)
    let epsilons =  indexes  |> map(e.init(index:))
    
    let _ = zip(indexes, epsilons).map { pairs in
      XCTAssertEqual(pairs.1, e(pairs.0))
    }
  }
  
}
