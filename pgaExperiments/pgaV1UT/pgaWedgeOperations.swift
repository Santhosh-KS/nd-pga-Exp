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
  
  // START: Test:|^| (_ lhs:[A], _ rhs:[A]) -> A
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
  
  // START: Test:|^| (_ lhs:A, _ rhs:(A, e)) -> (A, e)
  func testBVCUsingFloatAndBasisVector() {
    let f1 = 1.1
    let e1 = (2.2, e(1))
    
    let result = f1 |^| e1
    let result1 = 1.1 |^| (2.2, e(1))
    
    XCTAssertEqual(result.0, result1.0)
    XCTAssertEqual(result.1, result1.1)
  }
  
    // START: Test:|^| (_ lhs:[A], _ rhs:[(A, e)]) -> [(A, e)]
  func testBVCUsingArrayOfFloatsAndArrayOfBasisVectors() {
    let doubles = [1.1,1.2,1.3]
    let arrayOfE = [(2.1, e(1)),(2.2, e(2)),(2.3, e(3))]
    
    let result = doubles |^| arrayOfE
    let result1 = [1.1,1.2,1.3] |^| [(2.1, e(1)),(2.2, e(2)),(2.3, e(3))]
    
    XCTAssertEqual(result.count, result1.count)
    
    let _ = zip2(result1, result).map { pairs in
      let validating = pairs.0
      let result = pairs.1
      XCTAssertEqual(validating.0, result.0)
      XCTAssertEqual(validating.1, result.1)
    }
    
    let duplicateValues = [(10, e(1)), (20, e(2)), (30,e(1))]
    let vals = [2,3,4]
    let reducedResult = vals |^| duplicateValues
    let validatedResults = [2,3,4] |^| [(10, e(1)), (20, e(2)), (30,e(1))]
    
    XCTAssertNotEqual(reducedResult.count, 3)
    XCTAssertEqual(reducedResult.count, 2)
    
    XCTAssertNotEqual(validatedResults.count, 3)
    XCTAssertEqual(validatedResults.count, 2)
    XCTAssertEqual(reducedResult.count, validatedResults.count)
    
    XCTAssertEqual(reducedResult.first!.0, 2400)
    XCTAssertEqual(validatedResults.first!.0, 2400)
    XCTAssertEqual(reducedResult.first!.0 , validatedResults.first!.0)
    
    
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
  
    // START: Test:|^| (_ lhs:(A, e), _ rhs:A) -> (A, e)
  func testBVCUsingBasisVectorAndFloat() {
    let bv = (2.1, e(1))
    let val = 1.0
    
    let result = bv |^| val
    let result1 = (2.1, e(1)) |^| 1.0
    
    XCTAssertEqual(result.0, result1.0)
    XCTAssertEqual(result.1, result1.1)
    
    let bv1 = (2.1, e(1))
    
    let result2 = bv1 |^| val
    let result3 = (2.1, e(1)) |^| val
    
    XCTAssertEqual(result2.0, result3.0)
    XCTAssertEqual(result2.1, result3.1)
    
    let result4 = bv1 |^| 0.0
    XCTAssertEqual(result4.0, 0.0)
    XCTAssertEqual(result4.1, e(0))
    
    let result5 = (0, e(2)) |^| 10.0
    XCTAssertEqual(result5.0, 0.0)
    XCTAssertEqual(result5.1, e(0))
    
  }
  
    // START: Test:|^| (_ lhs:[(A, e)], _ rhs:[A]) -> [(A, e)]
  func testBVCUsingArrayOfBasisVectorAndArrayOfFloat() {
    let doubles = [1.1,1.2,1.3]
    let bvs = [(2.1, e(1)),(2.2, e(2)),(2.3, e(3))]
    
    let result = bvs |^| doubles
    let result1 = [(2.1, e(1)),(2.2, e(2)),(2.3, e(3))] |^| [1.1,1.2,1.3]
    
    XCTAssertEqual(result.count, result1.count)
    
    let _ = zip2(result1, result).map { pairs in
      let validating = pairs.0
      let result = pairs.1
      XCTAssertEqual(validating.0, result.0)
      XCTAssertEqual(validating.1, result.1)
    }
    
    let duplicateValues = [(10, e(1)), (20, e(2)), (30,e(1))]
    let vals = [2,3,4]
    let reducedResult = duplicateValues |^| vals
    let validatedResults = [(10, e(1)), (20, e(2)), (30,e(1))] |^| [2,3,4]
    
    XCTAssertNotEqual(reducedResult.count, 3)
    XCTAssertEqual(reducedResult.count, 2)
    
    XCTAssertNotEqual(validatedResults.count, 3)
    XCTAssertEqual(validatedResults.count, 2)
    XCTAssertEqual(reducedResult.count, validatedResults.count)
    
    XCTAssertEqual(reducedResult.first!.0, 2400)
    XCTAssertEqual(validatedResults.first!.0, 2400)
    XCTAssertEqual(reducedResult.first!.0 , validatedResults.first!.0)
    
    let arrayOfDoubles = (1...100).map { Double($0) * Double.pi }
    let arrayOfBasisVectors = (1...100).map { (Double($0)*Double.pi, e(UInt8($0))) }
    
    let actualResult = arrayOfBasisVectors |^| arrayOfDoubles
    let validationResults = zip2(with: |^|)(arrayOfBasisVectors, arrayOfDoubles)
    
    let _ = zip2(actualResult, validationResults).map { pairs in
      let validating = pairs.0
      let result = pairs.1
      XCTAssertEqual(validating.0, result.0)
      XCTAssertEqual(validating.1, result.1)
    }
  }
  
    // START: Test:|^| (_ lhs:A, rhs:e) -> (A, e)
  func testBVCUsingFloatAndEpsilon() {
    let val = 10.0
    let epsilon = e(1)
    
    let result = val |^| epsilon
    let result1 = 10.0 |^| e(1)
    
    XCTAssertEqual(result1.0, result.0)
    XCTAssertEqual(result1.1, result.1)
  }
  
    // START: Test: |^| (_ lhs:[A], rhs:[e]) -> [(A, e)]
  func testBVCUsingArrayOfFloatsAndArrayOfEpsilons() {
    let doubles = [10.0, 20, 30]
    let epsilons = [e(1),e(2),e(3)]
    
    let result = doubles |^| epsilons
    let result1 = [10.0, 20, 30] |^| [e(1),e(2),e(3)]
    
    XCTAssertEqual(result.count, min(doubles.count, epsilons.count))
    XCTAssertEqual(result1.count, min([10.0, 20, 30].count, [e(1),e(2),e(3)].count))

    XCTAssertEqual(result.count, result.count)
    let _ = zip2(result, result1).map { pairs in
      let rp = pairs.0
      let vp = pairs.1

      XCTAssertEqual(rp.0, vp.0)
      XCTAssertEqual(rp.1, vp.1)
    }
    
    let duplicateValues = [(10, e(1)), (20, e(2)), (30,e(1))]
    let vals = [2,3,4]
    let reducedResult = duplicateValues |^| vals
    let validatedResults = [(10, e(1)), (20, e(2)), (30,e(1))] |^| [2,3,4]
    
    XCTAssertNotEqual(reducedResult.count, 3)
    XCTAssertNotEqual(validatedResults.count, 3)
    
    XCTAssertEqual(reducedResult.count, 2)
    XCTAssertEqual(validatedResults.count, 2)
    XCTAssertEqual(reducedResult.count, validatedResults.count)
    
    XCTAssertEqual(reducedResult.first!.0, 2400)
    XCTAssertEqual(validatedResults.first!.0, 2400)
    XCTAssertEqual(reducedResult.first!.0 , validatedResults.first!.0)
    
    
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
  
    // START: Test: |^| (_ lhs:[e], rhs:[A]) -> [(A, [e])]
  func testBVCUsingUsingArrayOfEspilonsAndArrayOfFloat() {
    let doubles = [10.0, 20, 30]
    let epsilons = [e(1),e(2),e(3)]
    
    let result = epsilons |^| doubles
    let result1 = [e(1),e(2),e(3)] |^| [10.0, 20, 30]
    
    XCTAssertEqual(result.count, min(doubles.count, epsilons.count))
    XCTAssertEqual(result1.count, min([10.0, 20, 30].count, [e(1),e(2),e(3)].count))
    
    XCTAssertEqual(result.count, result.count)
    let _ = zip2(result, result1).map { pairs in
      let rp = pairs.0
      let vp = pairs.1
      
      XCTAssertEqual(rp.0, vp.0)
      XCTAssertEqual(rp.1, vp.1)
    }
    
    let duplicateValues = [(10, e(1)), (20, e(2)), (30,e(1))]
    let vals = [2,3,4]
    let reducedResult = vals |^| duplicateValues
    let validatedResults = [(10, e(1)), (20, e(2)), (30,e(1))] |^| [2,3,4]
    
    XCTAssertNotEqual(reducedResult.count, 3)
    XCTAssertNotEqual(validatedResults.count, 3)
    
    XCTAssertEqual(reducedResult.count, 2)
    XCTAssertEqual(validatedResults.count, 2)
    XCTAssertEqual(reducedResult.count, validatedResults.count)
    
    XCTAssertEqual(reducedResult.first!.0, 2400)
    XCTAssertEqual(validatedResults.first!.0, 2400)
    XCTAssertEqual(reducedResult.first!.0 , validatedResults.first!.0)
    
    let arrayOfDoubles = (1...100).map { Double($0) * Double.pi }
    let arrayOfBasisVectors = (1...100).map { (Double($0)*Double.pi, e(UInt8($0))) }
    
    let actualResult = arrayOfBasisVectors |^| arrayOfDoubles
    let validationResults = zip2(with: |^|)(arrayOfBasisVectors, arrayOfDoubles)
    
    let _ = zip2(actualResult, validationResults).map { pairs in
      let validating = pairs.0
      let result = pairs.1
      XCTAssertEqual(validating.0, result.0)
      XCTAssertEqual(validating.1, result.1)
    }
  }
  
  // START: Test: |^| (_ lhs:e, _ rhs:(A, e)) -> (A, [e])
  func testBVCUsingEpsilonAndBasisVector() {
    let epsilon1 = e(1)
    let bv = (10, e(2))
    
    let result = epsilon1 |^| bv
    let result1 = e(1) |^| (10, e(2))
    
    XCTAssertEqual(result.0, result1.0)
    XCTAssertEqual(result.1, result1.1)
    
    XCTAssertEqual(result.1.count, 2)
    XCTAssertEqual(result.1.count, result1.1.count)
    XCTAssertEqual(result.1, [e(1),e(2)])
    
    XCTAssertNotEqual(result1.1, [e(2), e(1)])
    
    let bv1 = (10, e(1))
    
    let result2 = epsilon1 |^| bv1
    let result3 = e(1) |^| (10, e(1))
    
    XCTAssertEqual(result2.0, 0)
    XCTAssertEqual(result3.0, 0)
    
    XCTAssertEqual(result2.1.isEmpty, result3.1.isEmpty)
    
    let arrayOfEpslions = (1...100).map { e(UInt8($0)) }
    let arrayOfBasisVectors = (1...100).map { (Double($0)*Double.pi, e(UInt8($0))) }
    
    let actualResult = arrayOfEpslions |^| arrayOfBasisVectors
    let validationResults = zip2(with: |^|)(arrayOfEpslions, arrayOfBasisVectors)
    
    let _ = zip2(actualResult, validationResults).map { pairs in
      let validating = pairs.0
      let result = pairs.1
      XCTAssertEqual(validating.0, result.0)
      XCTAssertEqual(validating.1, result.1)
    }
    
  }
  
  // START: Test: |^| (_ lhs:[e], _ rhs:[(A, e)]) -> [(A, [e])]
  func testBVCUsingArrayOfEpsilonsAndArrayOfBasisVectors() {
    let epsilons = [e(1),e(2)]
    let bvs = [(3, e(3)), (4, e(4))]
    
    let result = epsilons |^| bvs
    let result1 = [e(1), e(2)] |^| [(3, e(3)), (4, e(4))]
    
    XCTAssertEqual(result.count, 2)
    XCTAssertEqual(result.count, result1.count)
    
    XCTAssertEqual(result.first!.0, 3)
    XCTAssertEqual(result.first!.1, [e(1),e(3)])
    
    XCTAssertEqual(result.last!.0, 4)
    XCTAssertEqual(result.last!.1, [e(2),e(4)])
    
    XCTAssertEqual(result.first!.0, result1.first!.0)
    XCTAssertEqual(result.first!.1, result1.first!.1)
    
    XCTAssertEqual(result.last!.0, result1.last!.0)
    XCTAssertEqual(result.last!.1, result1.last!.1)
    
    
    let epsilons1 = [e(1),e(2)]
    let bvs1 = [(3, e(1)), (2, e(2))]
    
    let result2 = epsilons1 |^| bvs1
    let result3 = [e(1),e(2)] |^| [(3, e(1)), (2, e(2))]
    
    
    XCTAssertNotEqual(result2.count, 2)
    XCTAssertNotEqual(result3.count, min(epsilons1.count, bvs1.count))
    
    XCTAssertEqual(result2.count, 0)
    XCTAssertEqual(result3.count, 0)
    
  }
  
  // START: Test: |^| (_ lhs:(Float, e), _ rhs:e) -> (Float, [e])
  func testBVCUsingBasisVectorAndEpsilon() {
    let epsilon1 = e(1)
    let bv = (10, e(2))
    
    let result = bv |^| epsilon1
    let result1 = (10, e(2)) |^| e(1)
    
    XCTAssertEqual(result.0, result1.0)
    XCTAssertEqual(result.1, result1.1)
    
    XCTAssertEqual(result.1.count, 2)
    XCTAssertEqual(result.1.count, result1.1.count)
    XCTAssertEqual(result.1, [e(2),e(1)])
    
    XCTAssertNotEqual(result1.1, [e(1), e(2)])
    
    let bv1 = (10, e(1))
    
    let result2 = bv1 |^|  epsilon1
    let result3 = (10, e(1)) |^| e(1)
    
    XCTAssertEqual(result2.0, 0)
    XCTAssertEqual(result3.0, 0)
    
    XCTAssertEqual(result2.1.isEmpty, result3.1.isEmpty)
  }
  
    // START: Test: |^| (_ lhs:[(Float, e)], _ rhs:[e]) -> [(Float, [e])]
  func testBVCUsingArrayOfBasisVectorsAndArrayOfEpsilon() {
    let epsilons = [e(1),e(2)]
    let bvs = [(3, e(3)), (4, e(4))]
    
    let result = bvs |^| epsilons
    let result1 = [(3, e(3)), (4, e(4))] |^| [e(1), e(2)]
    
    XCTAssertEqual(result.count, 4)
    XCTAssertEqual(result.count, result1.count)
    
    XCTAssertEqual(result.first!.0, 3)
    XCTAssertEqual(result.first!.1, [e(3),e(1)])
    
    XCTAssertEqual(result.last!.0, 4)
    XCTAssertEqual(result.last!.1, [e(4),e(2)])
    
    XCTAssertEqual(result.first!.0, result1.first!.0)
    XCTAssertEqual(result.first!.1, result1.first!.1)
    
    XCTAssertEqual(result.last!.0, result1.last!.0)
    XCTAssertEqual(result.last!.1, result1.last!.1)
    
    let epsilons1 = [e(1),e(2)]
    let bvs1 = [(3, e(1)), (2, e(2))]
    
    let result2 = bvs1 |^| epsilons1
    let result3 = [(3, e(1)), (2, e(2))] |^| [e(1),e(2)]
    
    XCTAssertNotEqual(result2.count, 2)
    XCTAssertNotEqual(result3.count, min(epsilons1.count, bvs1.count))
    
    XCTAssertEqual(result2.count, 4)
    XCTAssertEqual(result3.count, 4)
    
    let arrayOfEpslions = (1...100).map { e(UInt8($0)) }
    let arrayOfBasisVectors = (1...100).map { (Double($0)*Double.pi, e(UInt8($0))) }
    
    let actualResult = arrayOfEpslions |^| arrayOfBasisVectors
    let validationResults = zip2(with: |^|)(arrayOfEpslions, arrayOfBasisVectors)
    
    let _ = zip2(actualResult, validationResults).map { pairs in
      let validating = pairs.0
      let result = pairs.1
      XCTAssertEqual(validating.0, result.0)
      XCTAssertEqual(validating.1, result.1)
    }
  }
  
    // START: Test: |^| (_ lhs:e, _ rhs:e) -> (A, [e])
  func testBVCUsing2Epsilons() {
    let epsilon1 = e(1)
    let epsilon2 = e(2)
    
    let result1 = epsilon1 |^| epsilon2
    let result2 = e(1) |^| e(2)
    
    XCTAssertEqual(result1, [e(1),e(2)])
    XCTAssertEqual(result1, result2)
    
    let result3 = epsilon1 |^| epsilon1
    let result4 = e(2) |^| e(2)
    
    XCTAssertEqual(result3, [])
    XCTAssertEqual(result3, result4)
    
    XCTAssertNotEqual(result3, [e(1), e(1)])
    XCTAssertNotEqual(result4, [e(2), e(2)])
  }
  
    // START: Test: |^| (_ lhs:[e], _ rhs:[e]) -> [(A, [e])]
  func testBVCUsing2ArraysOfEpsilon() {
    let epsilons1 = [e(1)]
    let epsilons2 = [e(2)]

    let result1 = epsilons1 |^| epsilons2
    let result2 = [e(1)] |^| [e(2)]

    XCTAssertEqual(result1.count, 1)

    XCTAssertEqual(result1.first!, [e(1),e(2)])

    XCTAssertEqual(result1, result2)

    let result3 = epsilons1 |^| epsilons1
    let result4 = [e(2)] |^| [e(2)]

    XCTAssertEqual(result3, [])
    XCTAssertEqual(result3, result4)

    XCTAssertNotEqual(result3, [[e(1), e(1)]])
    XCTAssertNotEqual(result4, [[e(2), e(2)]])

    let e12 = [e(1),e(2)]
    let e21 = [e(2),e(1)]

    let result5 = e12 |^| e21
    let result6 = ([e(1),e(2)] |^| [e(2),e(1)]).compactMap {  $0.isEmpty ? nil : $0 }

    XCTAssertEqual(result5.count, 2)
    XCTAssertEqual(result6.count, 2)

    XCTAssertEqual(result5.count, 2)
    XCTAssertEqual(result6.count, 2)

    let result7 = e21 |^| e21
    let result8 = [e(2),e(1)] |^| [e(2),e(1)]

    XCTAssertEqual(result7.count, 2)
    XCTAssertEqual(result8.count, 2)
    
    XCTAssertNotEqual(result7.count, 0)
    XCTAssertNotEqual(result8.count, 0)

  }
  
  // START: Test: |^| (_ lhs:(A, e), _ rhs:(A, e)) -> (A, [e])
  func testBVCUsing2BasisVectors() {
    let bv1 = (10, e(1))
    let bv2 = (20, e(2))
    
    let result1 = bv1 |^| bv2
    let result2 = (10, e(1)) |^| (20, e(2))
    
    XCTAssertEqual(result1.0, bv1.0*bv2.0)
    XCTAssertEqual(result1.1, [e(1),e(2)])
    
    XCTAssertEqual(result2.0, result1.0)
    XCTAssertEqual(result2.1, result1.1)
    
    let result3 = bv1 |^| bv1
    let result4 = bv2 |^| bv2
    
    XCTAssertNotEqual(result3.0, bv1.0*bv1.0)
    XCTAssertNotEqual(result4.0, bv2.0*bv2.0)
    
    XCTAssertEqual(result3.0, 0)
    XCTAssertEqual(result4.0, 0)
    
  }
  
    // START: Test: |^| (_ lhs:[(A, e)], _ rhs:[(A, e)]) -> [(A, [e])]
  func testBVCUsing2ArraysOfBasisVectors() {
    let e1 = [(10, e(1))]
    let e2 = [(20, e(2))]
    
    let result1 = e1 |^| e2
    let result2 = [(10, e(1))] |^| [(20, e(2))]
    
    XCTAssertEqual(result1.first!.0, e1.first!.0 * e2.first!.0)
    XCTAssertEqual(result1.first!.1, [e(1),e(2)])
    
    XCTAssertEqual(result2.first!.0, result1.first!.0)
    XCTAssertEqual(result2.first!.1, result1.first!.1)
    
    let result3 = e1 |^| e1
    let result4 = e2 |^| e2
    
    XCTAssertEqual(result3.count, 0)
    XCTAssertEqual(result4.count, 0)
    
    XCTAssertNotEqual(result3.count, 1)
    XCTAssertNotEqual(result4.count, 1)
  }
  
  // START: Test: |^| (_ lhs:(A,[e]), _ rhs:(A,[e])) -> (A,[e])
  func testBVCUsing2MultiVectors() {
    let mv1 = (10.0, [e(1), e(2)])
    let mv2 = (20.0, [e(3), e(4)])
    
    let result1 = mv1 |^| mv2
    let result2 = (10.0, [e(1), e(2)]) |^| (20.0, [e(3), e(4)])
    
    XCTAssertEqual(result1.0, mv1.0*mv2.0)
    XCTAssertEqual(result2.0, mv1.0*mv2.0)
    
//    XCTAssertEqual(result1.1, [e(1), e(2), e(3), e(4)])
    
    let result3 = mv1 |^| mv1
    
    XCTAssertNotEqual(result3.0, 0)
    XCTAssertNotEqual(result3.1, [])
    
    XCTAssertEqual(result3.0, 100)
    XCTAssertEqual(result3.1, [[e(1), e(2)], [e(2), e(1)]])
    
    let mv3 = (30.0, [e(2),e(3)])
    
    let result4 = mv1 |^| mv3
    XCTAssertNotEqual(result4.0, 0)
    XCTAssertNotEqual(result4.1, [])
    
    XCTAssertEqual(result4.0, 300)
    XCTAssertEqual(result4.1, [[e(1), e(2)], [e(1), e(3)], [e(2), e(3)]])
    
  }
  
    // START: Test: |^| (_ lhs:(A, e), _ rhs:(A, [e])) -> (A, [e])
  func testBVCUsingBasisVectorAndMultivector() {
    let bv = (10, e(1))
    let mv = (20, [e(2), e(3)])
    
    let result1 = bv |^| mv
    let result2 = (10, e(1)) |^| (20, [e(2), e(3)])
    
    XCTAssertEqual(result1.0, bv.0 * mv.0)
    XCTAssertEqual(result2.0, bv.0 * mv.0)
    
    XCTAssertEqual(result1.1, [e(1), e(2), e(3)])
    XCTAssertEqual(result2.1, [e(1), e(2), e(3)])
    
    let bv1 = (10, e(1))
    let mv1 = (20, [e(2), e(3), e(1)])
    
    let result3 = bv1 |^| mv1
    let result4 = (10, e(1)) |^| (20, [e(2), e(3), e(1)])
    
    XCTAssertNotEqual(result3.0, 0)
    XCTAssertNotEqual(result4.0, 0)
    
    XCTAssertEqual(result3.0, 200)
    XCTAssertEqual(result4.0, 200)
    
    XCTAssertEqual(result3.1, [])
    XCTAssertEqual(result4.1, [])
    
  }
  
  // START: Test: |^| (_ lhs:[(A, e)], _ rhs:[(A, [e])]) -> [(A, [e])]
  func testBVCUsingArrayOfBasisVectorsAndArrayOfMultiVector() {
    
    let bvs = [(10, e(1))]
    let mvs = [(20, [e(2), e(3)])]
    
    let result1 = bvs |^| mvs
    let result2 = [(10, e(1))] |^| [(20, [e(2), e(3)])]
    
    XCTAssertEqual(result1.first!.0, bvs.first!.0 * mvs.first!.0)
    XCTAssertEqual(result2.first!.0, bvs.first!.0 * mvs.first!.0)
    
    XCTAssertEqual(result1.first!.1, [e(1), e(2), e(3)])
    XCTAssertEqual(result2.first!.1, [e(1), e(2), e(3)])
    
    let bvs1 = [(10, e(1)), (20, e(2))]
    let mvs1 = [(30, [e(2), e(3), e(1)]), (40, [e(1), e(3)])]
    
    let result3 = bvs1 |^| mvs1
    let result4 = [(10, e(1)), (20, e(2))] |^| [(30, [e(2), e(3), e(1)]), (40, [e(1), e(3)])]
    
    XCTAssertEqual(result3.first!.0, 300)
    XCTAssertEqual(result4.first!.0, 300)
    
    XCTAssertNotEqual(result3.first!.0, 0)
    XCTAssertNotEqual(result4.first!.0, 0)
    
    XCTAssertEqual(result3.first!.1, [])
    XCTAssertEqual(result4.first!.1, [])
    
    XCTAssertEqual(result3.last!.0, 800)
    XCTAssertEqual(result4.last!.0, 800)
    
    XCTAssertEqual(result3.last!.1, [e(2), e(1), e(3)])
    XCTAssertEqual(result4.last!.1, [e(2), e(1), e(3)])
  }
  
    // START: Test: |^| (_ lhs:(A, [e]), _ rhs:(A, e)) -> (A, [e])
  func testBVCUsingMultivectorAndBasisVector() {
    let bv = (10, e(1))
    let mv = (20, [e(2), e(3)])
    
    let result1 = mv |^| bv
    let result2 = (20, [e(2), e(3)]) |^| (10, e(1))
    
    XCTAssertEqual(result1.0, bv.0 * mv.0)
    XCTAssertEqual(result2.0, bv.0 * mv.0)
    
    XCTAssertEqual(result1.1, [e(2), e(3), e(1)])
    XCTAssertEqual(result2.1, [e(2), e(3), e(1)])
    
    let bv1 = (10, e(1))
    let mv1 = (20, [e(2), e(3), e(1)])
    
    let result3 = mv1 |^| bv1
    let result4 = (20, [e(2), e(3), e(1)]) |^| (10, e(1))
    
    XCTAssertEqual(result3.0, 200)
    XCTAssertEqual(result4.0, 200)
    
    XCTAssertNotEqual(result3.0, 0)
    XCTAssertNotEqual(result4.0, 0)
    
    XCTAssertEqual(result3.1, [])
    XCTAssertEqual(result4.1, [])
    
  }
  
  // START: Test: |^| (_ lhs:[(A, [e])], _ rhs:[(A, e)]) -> [(A, [e])]
  func testBVCUsingArrayOfMultivectorsAndArrayOfBaisVector() {
    
    let bvs = [(10, e(1))]
    let mvs = [(20, [e(2), e(3)])]
    
    let result1 = mvs |^| bvs
    let result2 = [(20, [e(2), e(3)])]  |^| [(10, e(1))]
    
    XCTAssertEqual(result1.first!.0, bvs.first!.0 * mvs.first!.0)
    XCTAssertEqual(result2.first!.0, bvs.first!.0 * mvs.first!.0)
    
    XCTAssertEqual(result1.first!.1, [e(2), e(3), e(1)])
    XCTAssertEqual(result2.first!.1, [e(2), e(3), e(1)])
    
    let bvs1 = [(10, e(1)), (20, e(2))]
    let mvs1 = [(30, [e(2), e(3), e(1)]), (40, [e(1), e(3)])]
    
    let result3 = mvs1 |^| bvs1
    let result4 = [(30, [e(2), e(3), e(1)]), (40, [e(1), e(3)])] |^| [(10, e(1)), (20, e(2))]
    
    XCTAssertNotEqual(result3.first!.0, 0)
    XCTAssertNotEqual(result4.first!.0, 0)
    
    XCTAssertEqual(result3.first!.0, 300)
    XCTAssertEqual(result4.first!.0, 300)
    
    XCTAssertEqual(result3.first!.1, [])
    XCTAssertEqual(result4.first!.1, [])
    
    XCTAssertEqual(result3.last!.0, 800)
    XCTAssertEqual(result4.last!.0, 800)
    
    XCTAssertEqual(result3.last!.1, [e(1), e(3), e(2)])
    XCTAssertEqual(result4.last!.1, [e(1), e(3), e(2)])
  }
  
}


