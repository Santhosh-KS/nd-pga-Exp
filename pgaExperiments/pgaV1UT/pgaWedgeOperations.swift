//
//  pgaWedgeOperations.swift
//  pgaV1UT
//
//  Created by Santhosh K S on 23/08/22.
//

import XCTest

class pgaWedgeOperations: XCTestCase {
  
  
    // START: Test:|^| (_ lhs:Float, _ rhs:Float) -> (Float, [e])
  func testBVCUsing2Floats() {
    let f1:Float = 1.1
    let f2:Float = 2.1
    
    let result = f1 |^| f2
    let result1 = 1.1 |^| 2.1
    
    XCTAssertEqual(result, f1*f2)
    XCTAssertEqual(result1, Double(f1*f2), accuracy:0.0001)
    XCTAssertEqual(result1, Double(result), accuracy:0.0001)
  }
  
  // START: Test:|^| (_ lhs:[Float], _ rhs:[Float]) -> (Float, [e])
  func testBVCUsing2ArraysOfFloats() {
    let f1:[Float] = [1.1,1.2,1.3]
    let f2:[Float] = [2.1,2.2,2.3]
    
    let result = f1 |^| f2
    let result1 =  [1.1,1.2,1.3] |^| [2.1,2.2,2.3]
    XCTAssertEqual(result, f1.reduce(1, *) * f2.reduce(1, *))
    XCTAssertEqual(result1, Double(result), accuracy:0.0001)
    
    let validatedResult = zip2(with: |^|)(f1, f2).reduce(1, |^|)
    XCTAssertEqual(validatedResult, result)
    
    let arrayOfFloats1 = (1...1000).map {  Float($0) * Float.pi }
    let arrayOfFloats2 = Array(arrayOfFloats1.reversed())
    
    let result2 = arrayOfFloats1 |^| arrayOfFloats2
    
    let validatedResult2 = zip2(with: |^|)(arrayOfFloats1 , arrayOfFloats2).reduce(1, |^|)
    XCTAssertEqual(validatedResult2, result2)
  }
  
    // START: Test:|^| (_ lhs:Float, _ rhs:(Float, e)) -> (Float, [e])
  func testBVCUsingFloatAndBasisVector() {
    let f1 = 1.1
    let basisVector = (2.2, e(1))
    
    let result = f1 |^| basisVector
    let result1 = 1.1 |^| (2.2, e(1))
    
    XCTAssertEqual(result.0, result1.0)
    XCTAssertEqual(result.1, result1.1)
  }
  
    // START: Test:|^| (_ lhs:[Float], _ rhs:[(Float, e)]) -> [(Float, [e])]
  func testBVCUsingArrayOfFloatsAndArrayOfBasisVectors() {
    let doubles = [1.1,1.2,1.3]
    let bvs = [(2.1, e(1)),(2.2, e(2)),(2.3, e(3))]
    
    let result = doubles |^| bvs
    let result1 = [1.1,1.2,1.3] |^| [(2.1, e(1)),(2.2, e(2)),(2.3, e(3))]
    
    XCTAssertEqual(result.count, result1.count)
    
    let _ = zip2(result1, result).map { pairs in
      let validating = pairs.0
      let result = pairs.1
      XCTAssertEqual(validating.0, result.0)
      XCTAssertEqual(validating.1, result.1)
    }
    
    let arrayOfDoubles = (1...100).map { Double($0) * Double.pi }
    let arrayOfBasisVectors = (1...100).map { (Double($0)*Double.pi, e(UInt8($0))) }
    
    let actualResult = arrayOfDoubles |^| arrayOfBasisVectors
    let validationResults = zip2(with: |^|)(arrayOfDoubles, arrayOfBasisVectors)
    
    let _ = zip2(actualResult, validationResults).map { pairs in
      let validating = pairs.0
      let result = pairs.1
      XCTAssertEqual(validating.0, result.0)
      XCTAssertEqual(validating.1, result.1)
    }
  }
  
    // START: Test:|^| (_ lhs:(Float, e), _ rhs:Float) -> (Float, [e])
  func testBVCUsingBasisVectorAndFloat() {}
  
    // START: Test:|^| (_ lhs:[(Float, e)], _ rhs:[Float]) -> [(Float, [e])]
  func testBVCUsingArrayOfBasisVectorAndArrayOfFloat() {}
  
    // START: Test:|^| (_ lhs:Float, rhs:e) -> (Float, [e])
  func testBVCUsingFloatAndEpsilon() { }
  
    // START: Test: |^| (_ lhs:[Float], rhs:[e]) -> [(Floa|^| (_ lhs:e, rhs:Float) -> (Float, [e])
  func testBVCUsingArrayOfFloatsAndArrayOfEpsilons() { }
  
    // START: Test: |^| (_ lhs:[e], rhs:[Float]) -> [(Float, [e])]
  func testBVCUsingUsingArrayOfEspilonsAndArrayOfFloat() { }
  
    // START: Test: |^| (_ lhs:e, _ rhs:(Float, e)) -> (Float, [e])
  func testBVCUsingEpsilonAndBasisVector() { }
  
    // START: Test: |^| (_ lhs:[e], _ rhs:[(Float, e)]) -> [(Float, [e])]
  func testBVCUsingArrayOfEpsilonsAndArrayOfBasisVecotros() { }
  
    // START: Test: |^| (_ lhs:(Float, e), _ rhs:e) -> (Float, [e])
  func testBVCUsingBasisVectorAndEpsilon() { }
  
    // START: Test: |^| (_ lhs:[(Float, e)], _ rhs:[e]) -> [(Float, [e])]
  func testBVCUsingArrayOfBasisVectorsAndArrayOfEpsilon() { }
  
    // START: Test: |^| (_ lhs:e, _ rhs:e) -> (Float, [e])
  func testBVCUsing2Epsilons() { }
  
    // START: Test: |^| (_ lhs:[e], _ rhs:[e]) -> [(Float, [e])]
  func testBVCUsing2ArraysOfEpsilon() { }
  
    // START: Test: |^| (_ lhs:(Float, e), _ rhs:(Float, e)) -> (Float, [e])
  func testBVCUsing2BasisVectors() { }
  
    // START: Test: |^| (_ lhs:[(Float, e)], _ rhs:[(Float, e)]) -> [(Float, [e])]
  func testBVCUsing2ArraysOfBasisVectors() { }
  
    // START: Test: |^| (_ lhs:(Float,[e]), _ rhs:(Float,[e])) -> (Float,[e])
  func testBVCUsing2MultiVectors() { }
  
    // START: Test: |^| (_ lhs:(Float, e), _ rhs:(Float, [e])) -> (Float, [e])
  func testBVCUsingBasisVectorAndMultivector() { }
  
    // START: Test: |^| (_ lhs:[(Float, e)], _ rhs:[(Float, [e])]) -> [(Float, [e])]
  func testBVCUsingArrayOfBasisVectorsAndArrayOfMultiVector() { }
  
    // START: Test: |^| (_ lhs:(Float, [e]), _ rhs:(Float, e)) -> (Float, [e])
  func testBVCUsingMultivectorAndBasisVector() { }
  
    // START: Test: |^| (_ lhs:[(Float, [e])], _ rhs:[(Float, e)]) -> [(Float, [e])]
  func testBVCUsingArrayOfMultivectorsAndArrayOfBaisVector() { }
}


