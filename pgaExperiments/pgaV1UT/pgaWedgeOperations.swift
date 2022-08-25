//
//  pgaWedgeOperations.swift
//  pgaV1UT
//
//  Created by Santhosh K S on 23/08/22.
//

import XCTest

class pgaWedgeOperations: XCTest {
  
  
    // START: Test:|^| (_ lhs:Float, _ rhs:Float) -> (Float, [e])
  func testBVCUsing2Floats() {}
  
    // START: Test:|^| (_ lhs:[Float], _ rhs:[Float]) -> (Float, [e])
  func testBVCUsing2ArraysOfFloats() {}
  
    // START: Test:|^| (_ lhs:Float, _ rhs:(Float, e)) -> (Float, [e])
  func testBVCUsingFloatAndBasisVector() {}
  
    // START: Test:|^| (_ lhs:[Float], _ rhs:[(Float, e)]) -> [(Float, [e])]
  func testBVCUsingArrayOfFloatsAndArrayOfBasisVectors() {}
  
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


