import XCTest

class pgaAdditionOperations: XCTestCase {
  
  let indexes:[UInt8] = [0,1,2,3,4,5,6,7,8,9,10]
  var epsilons:[e]  { indexes |> map(e.init(index:)) }
  var e0:e { epsilons.first! }
  let coefficient = Double.pi
  
  // START: Test: |+| (_ lhs:Float, _ rhs:Float)  -> (Float, e)
  func test2Floats() {
    let lhs = coefficient |+| coefficient
    let rhs = Double.pi  + Double.pi
    XCTAssertEqual(lhs, rhs, accuracy:0.0001)
  }
  
  func testFloatsMultiplicationPrecedence() {
    let lhs1 =  coefficient*coefficient |+| coefficient*coefficient
    let rhs1 = coefficient*coefficient  +  coefficient*coefficient
    XCTAssertEqual(lhs1, rhs1)
  }
  
  func testFloatsAdditionSubstractionPrecedence() {
    let lhs2 =  coefficient+coefficient |+| coefficient-coefficient
    let rhs2 =  coefficient+coefficient  +  coefficient-coefficient
    XCTAssertEqual(lhs2, rhs2, accuracy:0.0001)
  }
  
  func testFloatsDivisionPrecedence() {
    let lhs3 =  coefficient/coefficient |+| coefficient/coefficient
    let rhs3 =  coefficient/coefficient  +  coefficient/coefficient
    XCTAssertEqual(lhs3, rhs3, accuracy:0.0001)
  }
  
  // START: Test: |+| (_ lhs:[Float], _ rhs:[Float])  -> [(Float, e)]
  func testArrayOfFloats() {
    let f1 = Array(Int8.min...Int8.max) |> map { Double($0) * Double.pi }
    let f2 = Array(f1.reversed())
    
    let lhs = f1 |+| f2
    let rhs = zip2(with: |+|)(f1, f2).reduce(0, |+|)
    XCTAssertEqual(lhs, rhs, accuracy:0.0001)
  }
  
  // START: Test: |+| (_ lhs:Float, _ rhs:e)  -> [(Float, e)]
  func testBasisVectorCreationUsingFloatAndepsilon() {
    let lhs:[(Float, e)] =  10 |+| e(1)
    
    XCTAssertEqual(lhs.count, 2)
    
    XCTAssertEqual(lhs.first!.0, 10)
    XCTAssertEqual(lhs.first!.1, e(0))
    XCTAssertEqual(lhs.last!.0, 1)
    XCTAssertEqual(lhs.last!.1, e(1))
  }
  
  // START: Test: |+| (_ lhs:e, _ rhs:Float)  -> [(Float, e)]
  func testAdditionCommutativity() {
    let lhs: [(Float, e)] =   10  |+| e(1)
    let lhs1:[(Float, e)] =  e(1) |+|  10
    
    XCTAssertEqual(lhs.count, 2)
    XCTAssertEqual(lhs.first!.0, 10)
    XCTAssertEqual(lhs.first!.1, e(0))
    XCTAssertEqual(lhs.last!.0, 1)
    XCTAssertEqual(lhs.last!.1, e(1))
    
    XCTAssertEqual(lhs1.count, 2)
    XCTAssertEqual(lhs1.first!.0, 10)
    XCTAssertEqual(lhs1.first!.1, e(0))
    XCTAssertEqual(lhs1.last!.0, 1)
    XCTAssertEqual(lhs1.last!.1, e(1))
    
  }
  
  // START: Test: |+| (_ lhs:[Float], _ rhs:[e])  -> [(Float, e)]
  func testBasisVectorsCreationUsingArrayOfFloatsAndArrayOfepsilons() {
    
    let arrayOfFloats:[Float] = Array(Int8.min...Int8.max) |> map { Float($0) * Float.pi }
    let arrayOfEpsilons:[e]   = Array(UInt8.min...UInt8.max) |> map(e.init(index:))
    
    let arrayOfVectors = arrayOfFloats |+| arrayOfEpsilons
    
    let validateResults = zip2(with: |+|) (arrayOfFloats, arrayOfEpsilons) |> flatmap
    
    XCTAssertEqual(arrayOfVectors.count, validateResults.count)
    
    let _ = zip2(arrayOfVectors, validateResults).map { pairs in
      let validating:(coef:Float, E:e) = pairs.0
      let result:(coef:Float, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
  }
  
  // START: Test: |+| (_ lhs:[e], _ rhs:[Float])  -> [(Float, e)]
  func testBasisVectorsCreationUsingArrayOfEpsilonsAndArrayOfFloats() {
    
    let arrayOfFloats:[Float] = Array(Int8.min...Int8.max) |> map { Float($0) * Float.pi }
    let arrayOfEpsilons:[e]   = Array(UInt8.min...UInt8.max) |> map(e.init(index:))
    
    let arrayOfVectors = arrayOfEpsilons |+| arrayOfFloats
    
    let validateResults = zip2(with: |+|) (arrayOfEpsilons, arrayOfFloats) |> flatmap
    
    XCTAssertEqual(arrayOfVectors.count, validateResults.count)
    
    let _ = zip2(arrayOfVectors, validateResults).map { pairs in
      let validating:(coef:Float, E:e) = pairs.0
      let result:(coef:Float, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
  }
  
  // START: Test: |+| (_ lhs:e, _ rhs:e)  -> [(Float, e)]
  func testBasiVectorCreationUsing2Epsilons() {
    
    let result:[(Double, e)] = e(1) |+| e(2)
    
    XCTAssertEqual(result.count, 2)
    XCTAssertEqual(result.first!.0, Double(1))
    XCTAssertEqual(result.first!.1, e(1))
    
    XCTAssertEqual(result.last!.0, Double(1))
    XCTAssertEqual(result.last!.1, e(2))
  }
  
  // START: Test: |+| (_ lhs:[e], _ rhs:[e])  -> [(Float, e)]
  func testBasiVectorCreationUsing2ArraysOfEpsilons() {
    
    let result:[(Double, e)] = [e(0), e(1)] |+| [e(2), e(3)]
    
    let validateResults:[(Double, e)] = zip2(with: |+|)([e(0), e(1)], [e(2), e(3)]) |> flatmap
    
    XCTAssertEqual(result.count, validateResults.count)
    
    let _ = zip2(validateResults, result).map { pairs in
      let validating:(coef:Double, E:e) = pairs.0
      let result:(coef:Double, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
    
    let epsilons1 = epsilons
    let epsilons2 = Array(epsilons1.reversed())
    
    XCTAssertEqual(epsilons1.count, epsilons2.count)
    
    let result1:[(Double,e)] = epsilons1 |+| epsilons2
    
    let validateResults1:[(Double,e)] = zip2(with: |+|)(epsilons1, epsilons2) |> flatmap
    let _ = zip2(validateResults1, result1).map { pairs in
      let validating:(coef:Double, E:e) = pairs.0
      let result:(coef:Double, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
  }
  
  // START: Test: |+| (_ lhs:Float, _ rhs:(Float, e)) -> [(Float, e)]
  func testBasisVectorCreationUsingFloatAndBasisVector() {
    
    let result = 10 |+| (1.1, e1)
    
    XCTAssertEqual(result.count, 2)
    XCTAssertEqual(result.first!.0, Double(10))
    XCTAssertEqual(result.first!.1, e(0))
    
    XCTAssertEqual(result.last!.0, Double(1.1))
    XCTAssertEqual(result.last!.1, e(1))
  }
  
  // START: Test: |+| (_ lhs:(Float, e), _ rhs:Float) -> [(Float, e)]
  func testBasisVectorCreationUsingBasisVectorAndFloat() {
    
    let result = (2.1, e1) |+| 10
    
    XCTAssertEqual(result.count, 2)
    XCTAssertEqual(result.first!.0, Double(10))
    XCTAssertEqual(result.first!.1, e(0))
    
    XCTAssertEqual(result.last!.0, Double(2.1))
    XCTAssertEqual(result.last!.1, e(1))
  }
  
  // START: Test: |+| (_ lhs:[Float], _ rhs:[(Float, e)]) -> [(Float, e)]
  func testBasisVectorCreationUsingArrayOfFloatsAndArrayOfBasisVectors() {
    let f1:[Float] = [1, 2, 3]
    let bv1:[(Float,e)] = [(1.1,e(1)), (2.2,e(2)), (3.3,e(3))]
    
    let result = f1 |+| bv1
    
    let validateResults = zip2(with: |+|)(f1, bv1) |> flatmap
    
    XCTAssertEqual(result.count, validateResults.count)
    
    let _ = zip2(validateResults, result).map { pairs in
      let validating:(coef:Float, E:e) = pairs.0
      let result:(coef:Float, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
    
    let arrayOfFloats = Array(1...epsilons.count).map { Float($0) * Float.pi }
    let arrayOfBasisVectors = zip2(arrayOfFloats, epsilons)
    
    XCTAssertEqual(arrayOfBasisVectors.count, arrayOfFloats.count)
    
    let result1 = arrayOfFloats |+| arrayOfBasisVectors
    
    let validateResults1 = zip2(with: |+|)(arrayOfFloats, arrayOfBasisVectors) |> flatmap
    let _ = zip2(validateResults1, result1).map { pairs in
      let validating:(coef:Float, E:e) = pairs.0
      let result:(coef:Float, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
  }
  
  // START: Test: |+| (_ lhs:[(Float, e)], _ rhs:[Float]) -> [(Float, e)]
  func testBasisVectorCreationUsingArrayOfBasisVectorsAndArrayOfFloats() {
    let f1:[Float] = [1, 2, 3]
    let bv1:[(Float,e)] = [(1.1,e(1)), (2.2,e(2)), (3.3,e(3))]
    
    let result = bv1 |+| f1
    
    let validateResults = zip2(with: |+|)(bv1, f1) |> flatmap
    
    XCTAssertEqual(result.count, validateResults.count)
    
    let _ = zip2(validateResults, result).map { pairs in
      let validating:(coef:Float, E:e) = pairs.0
      let result:(coef:Float, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
    
    let arrayOfFloats = Array(1...epsilons.count).map { Float($0) * Float.pi }
    let arrayOfBasisVectors = zip2(arrayOfFloats, epsilons)
    
    XCTAssertEqual(arrayOfBasisVectors.count, arrayOfFloats.count)
    
    let result1 = arrayOfBasisVectors |+| arrayOfFloats
    let validateResults1 = zip2(with: |+|)(arrayOfBasisVectors, arrayOfFloats) |> flatmap
    
    let _ = zip2(validateResults1, result1).map { pairs in
      let validating:(coef:Float, E:e) = pairs.0
      let result:(coef:Float, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
  }
  
  // START: Test: |+| (_ lhs:(Float,e), _ rhs:(Float,e)) -> [(Float,e)]
  func testBasisVectorCreationUsing2BasisVectors() {
    
    let result:[(Double,e)] = e(1) |+| e(2)
    let result1:[(Double,e)] = (1, e(1)) |+| (1, e(2))
    
    XCTAssertEqual(result.count, result1.count)
    
    XCTAssertEqual(result.first!.0, result1.first!.0)
    XCTAssertEqual(result.first!.1, result1.first!.1)
    
    XCTAssertEqual(result.last!.0, result1.last!.0)
    XCTAssertEqual(result.last!.0, result1.last!.0)
    
    let result2 = (10, e(1)) |+| (20, e(2))
    XCTAssertEqual(result1.last!.1, result2.last!.1)
  }
  
  // START: Test: |+| (_ lhs:[(Float,e)], _ rhs:[(Float,e)]) -> [(Float,e)]
  func testBasisVectorCreationUsing2ArraysOfBasisVectors() {
    
    let bv1:[(Float,e)] = [(1.1,e(1)), (2.2,e(2)), (3.3,e(3))]
    let bv2 = Array(bv1.reversed())
    
    let result = bv1 |+| bv2
//    let r1 = (Float(1.1),e(1)) |+| (Float(2.2), e(2)) |+| bv1
    
    let validateResults = zip2(with: |+|)(bv1, bv2) |> flatmap
    
    XCTAssertEqual(result.count, validateResults.count)
    
    let _ = zip2(validateResults, result).map { pairs in
      let validating:(coef:Float, E:e) = pairs.0
      let result:(coef:Float, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
    
    let arrayOfFloats = Array(1...epsilons.count).map { Float($0) * Float.pi }
    let arrayOfBasisVectors = zip2(arrayOfFloats, epsilons)
    let arrayOfBasisVectors1 = Array(arrayOfBasisVectors.reversed())
    
    XCTAssertEqual(arrayOfBasisVectors.count, arrayOfBasisVectors1.count)
    
    let result1 = arrayOfBasisVectors |+| arrayOfBasisVectors1
    
    let validateResults1 = zip2(with: |+|)(arrayOfBasisVectors, arrayOfBasisVectors1) |> flatmap
    let _ = zip2(validateResults1, result1).map { pairs in
      let validating:(coef:Float, E:e) = pairs.0
      let result:(coef:Float, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
  }

  // START: Test: |+| (_ lhs:[(Float,e)], _ rhs:Float) -> [(Float,e)]
  func testBasisVectorCreationUsingArrayOfBasisVectorAndArrayOfFloats() {
    
    let arrayOfBasisVectors:[(Float,e)] = [(1.1,e(1)), (2.2,e(2)), (3.3,e(3))]
    let arrayOfFloats = Array(1...arrayOfBasisVectors.count).map {
      Float($0) * Float.pi
    }
    
    let result = arrayOfBasisVectors |+| arrayOfFloats
      //    let r1 = (Float(1.1),e(1)) |+| (Float(2.2), e(2)) |+| bv1
    let validateResults = zip2(with: |+|)(arrayOfBasisVectors, arrayOfFloats) |> flatmap
    
    XCTAssertEqual(result.count, validateResults.count)
    
    let _ = zip2(validateResults, result).map { pairs in
      let validating:(coef:Float, E:e) = pairs.0
      let result:(coef:Float, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
    
    let arrayOfBasisVectors1 = zip2(arrayOfFloats, epsilons)

    
    XCTAssertEqual(arrayOfFloats.count, arrayOfBasisVectors1.count)
    
    let result1 = arrayOfBasisVectors1 |+| arrayOfFloats
    
    let validateResults1 = zip2(with: |+|)(arrayOfBasisVectors1, arrayOfFloats) |> flatmap
    let _ = zip2(validateResults1, result1).map { pairs in
      let validating:(coef:Float, E:e) = pairs.0
      let result:(coef:Float, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
  }
  
  // START: Test: |+| (_ lhs:[[(Float,e)]], _ rhs:[Float])
  func testBasisVectorCreationUsingNestedBasisVectorsAndArrayOfFloats() {
    
    let nestedBasisVectors:[[(Float,e)]] = [[(1.1,e(1))], [(2.2,e(2))], [(3.3,e(3))]]
    let arrayOfFloats = Array(1...nestedBasisVectors.count).map {
      Float($0) * Float.pi
    }
    
    let result = nestedBasisVectors |+| arrayOfFloats
      //    let r1 = (Float(1.1),e(1)) |+| (Float(2.2), e(2)) |+| bv1
    
    let validateResults = zip2(with: |+|)(nestedBasisVectors, arrayOfFloats) |> flatmap
    
    XCTAssertEqual(result.count, validateResults.count)
    
    let _ = zip2(validateResults, result).map { pairs in
      let validating:(coef:Float, E:e) = pairs.0
      let result:(coef:Float, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
    
    let arrayOfBasisVectors1 = [zip2(arrayOfFloats, epsilons)]
    
    XCTAssertEqual(arrayOfBasisVectors1.count, 1)
    
    let result1 = arrayOfBasisVectors1 |+| arrayOfFloats
    
    let validateResults1 = zip2(with: |+|)(arrayOfBasisVectors1, arrayOfFloats) |> flatmap
    let _ = zip2(validateResults1, result1).map { pairs in
      let validating:(coef:Float, E:e) = pairs.0
      let result:(coef:Float, E:e) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
  }
  
  // START: Test: |+| (_ lhs:[(Float,e)], _ rhs:(Float,e))  -> [(Float,e)]
  func testBasisVectorCreationUsingArrayOfBasisVectorsAndBasisVector() {
    let basisVector:(Float, e) = (10, e(1))
    let arrayOfBasisVector:[(Float,e)] = [(1.1,e(1)), (2.2,e(2)), (3.3,e(3))]
    
    let result = arrayOfBasisVector |+| basisVector
    XCTAssertEqual(result.count, 3)
    XCTAssertEqual(result.first!.0, arrayOfBasisVector.first!.0+basisVector.0)
  }
  
  // START: Test: |+| (_ lhs:(Float,e), _ rhs:[(Float,e)])
  func testBasisVectorCreationUsingBasisVectorAndArrayOfBasisVectors() {
    let basisVector:(Float, e) = (10, e(1))
    let arrayOfBasisVector:[(Float,e)] = [(1.1,e(1)), (2.2,e(2)), (3.3,e(3))]
    
    let result = basisVector |+| arrayOfBasisVector
    XCTAssertEqual(result.count, 3)
    XCTAssertEqual(result.first!.0, arrayOfBasisVector.first!.0+basisVector.0)
  }
  
  // START: Test: |+| (_ lhs:(Float, e), _ rhs:(Float,[e])) -> [(Float,[e])]
  func testBasisVectorCreationUsingBasisVectorAndMultiVector() {
    let basisVector:(Float, e) = (10, e(1))
    let multiVector:(Float,[e]) = (1.1,[e(1),e(2),e(3)])
    
    let result = basisVector |+| multiVector
    XCTAssertEqual(result.count, 2)
    XCTAssertEqual(result.first!.0, 10)
    XCTAssertEqual(result.first!.1, [e(1)])
    XCTAssertEqual(result.last!.0, 1.1)
    XCTAssertEqual(result.last!.1.count, 3)
    XCTAssertEqual(result.last!.1, [e(1),e(2),e(3)])
  }
  
  // START: Test: |+| (_ lhs:[(Float, e)], _ rhs:[(Float,[e])]) -> [(Float,[e])]
  func testBasisVectorCreationUsingArrayOfBasisVectorAndArrayOfMultiVector() {
    let basisVectors:[(Float, e)] = [(10, e(1)), (20, e(2))]
    let multiVectors:[(Float,[e])] = [(1.1,[e(1),e(2),e(3)]), (2.2,[e(4),e(5),e(6)])]
    
    let result = basisVectors |+| multiVectors
    XCTAssertEqual(result.count, 4)
    
    let validateResults = zip2(with: |+|)(basisVectors, multiVectors) |> flatmap
    XCTAssertEqual(result.count, validateResults.count)
    
    let _ = zip2(validateResults, result).map { pairs in
      let validating:(coef:Float, E:[e]) = pairs.0
      let result:(coef:Float, E:[e]) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
  }
  // START: Test: |+| (_ lhs:(Float, [e]), _ rhs:(Float,e)) -> [(Float,[e])]
  func testBasisVectorCreationUsingMultiVectorAndBasisVector() {
    let basisVector:(Float, e) = (10, e(1))
    let multiVector:(Float,[e]) = (1.1,[e(1),e(2),e(3)])
    
    let result = multiVector |+| basisVector
    XCTAssertEqual(result.count, 2)
    XCTAssertEqual(result.first!.0, 10)
    XCTAssertEqual(result.first!.1, [e(1)])
    XCTAssertEqual(result.last!.0, 1.1)
    XCTAssertEqual(result.last!.1.count, 3)
    XCTAssertEqual(result.last!.1, [e(1),e(2),e(3)])
  }
  // START: Test: |+| (_ lhs:[(Float, [e])], _ rhs:[(Float,e)]) -> [(Float,[e])]
  func testBasisVectorCreationUsingArrayOfMultiVectorAndArrayOfBasisVector() {
    let basisVectors:[(Float, e)] = [(10, e(1)), (20, e(2))]
    let multiVectors:[(Float,[e])] = [(1.1,[e(1),e(2),e(3)]), (2.2,[e(4),e(5),e(6)])]
    
    let result = multiVectors |+| basisVectors
    XCTAssertEqual(result.count, 4)
    
    let validateResults = zip2(with: |+|)(multiVectors, basisVectors) |> flatmap
    XCTAssertEqual(result.count, validateResults.count)
    
    let _ = zip2(validateResults, result).map { pairs in
      let validating:(coef:Float, E:[e]) = pairs.0
      let result:(coef:Float, E:[e]) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
  }
  // START: Test: |+| (_ lhs:(Float, [e]), _ rhs:(Float,[e])) -> [(Float,[e])]
  func testBasisVectorCreationUsing2Multivectors() {
    let multiVector1:(Float,[e]) = (10,[e(1),e(2),e(3)])
    let multiVector2:(Float,[e]) = (2.2,[e(2),e(3),e(4)])
    
    let result = multiVector1 |+| multiVector1
    XCTAssertEqual(result.count, 1)
    
    XCTAssertEqual(result.first!.0, 20)
    XCTAssertEqual(result.first!.1, [e(1),e(2),e(3)])
    
    let result1 = multiVector1 |+| multiVector2
    XCTAssertEqual(result1.count, 2)
    XCTAssertEqual(result1.first!.0, 10)
    XCTAssertEqual(result1.first!.1, [e(1),e(2),e(3)])
    XCTAssertEqual(result1.last!.0, 2.2)
    XCTAssertEqual(result1.last!.1.count, 3)
    XCTAssertEqual(result1.last!.1, [e(2),e(3),e(4)])

  }
  
  // START: Test: |+| (_ lhs:[(Float, [e])], _ rhs:[(Float,[e])]) -> [(Float,[e])]
  func testBasisVectorCreationUsing2ArrayOfMultivectors() {
    let multiVector1:[(Float,[e])] = [(10,[e(1),e(2),e(3)]), (20,[e(2),e(3),e(4)])]
    let multiVector2:[(Float,[e])] = [(2.2,[e(2),e(3),e(4)]), (3.3,[e(3),e(4),e(5)])]
    
    let result = multiVector1 |+| multiVector1
    XCTAssertEqual(result.count, 2)
    
    XCTAssertEqual(result.first!.0, 20)
    XCTAssertEqual(result.first!.1, [e(1),e(2),e(3)])
    
    let validateResults = zip2(with: |+|)(multiVector1, multiVector1) |> flatmap
    XCTAssertEqual(result.count, validateResults.count)
    
    let _ = zip2(validateResults, result).map { pairs in
      let validating:(coef:Float, E:[e]) = pairs.0
      let result:(coef:Float, E:[e]) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
    
    let result1 = multiVector1 |+| multiVector2
    XCTAssertEqual(result1.count, 4)
    XCTAssertEqual(result1.first!.0, 10)
    XCTAssertEqual(result1.first!.1, [e(1),e(2),e(3)])
    XCTAssertEqual(result1.last!.0, 3.3)
    XCTAssertEqual(result1.last!.1.count, 3)
    XCTAssertEqual(result1.last!.1, [e(3),e(4),e(5)])
    
    let validateResults1 = zip2(with: |+|)(multiVector1, multiVector2) |> flatmap
    XCTAssertEqual(result1.count, validateResults1.count)
    
    let _ = zip2(validateResults1, result1).map { pairs in
      let validating:(coef:Float, E:[e]) = pairs.0
      let result:(coef:Float, E:[e]) = pairs.1
      XCTAssertEqual(validating.coef, result.coef)
      XCTAssertEqual(validating.E, result.E)
    }
    
  }

}
