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
  
  func testScalarAddition() {
    XCTAssertEqual(10 |+| 15, 10+15)
    
    XCTAssertEqual([1,2,3,4] |+| [5,6,7,8,9], 1+2+3+4+5+6+7+8)
    XCTAssertEqual([1,2,3,4] |+| [5,6,7,8,9], [1,2,3,4,5,6,7,8].reduce(0, +))
  }
  
  func testScalarAddGrade1() {
    let e01 = 10 |+| e(1)
    XCTAssertEqual(e01.first!.0, 10)
    XCTAssertEqual(e01.first!.1.first, nil)
    
    XCTAssertEqual(e01.last!.0, 1)
    XCTAssertEqual(e01.last!.1.first!, e(1))
    
    let e02 = e(2) |+| 123
    XCTAssertEqual(e02.first!.0, 123)
    XCTAssertEqual(e02.first!.1.first, nil)
    
    XCTAssertEqual(e02.last!.0, 1)
    XCTAssertEqual(e02.last!.1.first!, e(2))
  }
  
  func testGrade1AddGrade1() {
    let e00:[(Double, e)] = e(0) |+| e(0)
    XCTAssertEqual(e00.first!.0, 2)
    XCTAssertEqual(e00.first!.1, e(0))
    
    let e11:[(Double, e)] = e(1) |+| e(1)
    XCTAssertEqual(e11.first!.0, 2)
    XCTAssertEqual(e11.first!.1, e(1))
    
    let e02:[(Double, e)] = e(2) |+| e(2)
    XCTAssertEqual(e02.first!.0, 2)
    XCTAssertEqual(e02.first!.1, e(2))
    
    XCTAssertEqual(e02.last!.0, 2)
    XCTAssertEqual(e02.last!.1, e(2))
    
    let e03:[(Double, e)] = e(3) |+| e(3)
    XCTAssertEqual(e03.first!.0, 2)
    XCTAssertEqual(e03.first!.1, e(3))
    
    let e01:[(Double, e)] = e(0) |+| e(1)
    XCTAssertEqual(e01.first!.0, 1)
    XCTAssertEqual(e01.first!.1, e(0))
    
    let e12:[(Double, e)] = e(1) |+| e(2)
    XCTAssertEqual(e12.first!.0, 1)
    XCTAssertEqual(e12.first!.1, e(1))
    
    // Commutativity wrt addition.
    let e21:[(Double, e)] = e(2) |+| e(1)
    XCTAssertEqual(e12.first!.0, e21.last!.0)
    XCTAssertEqual(e12.last!.0,  e21.first!.0)
  }
  
  func testGrade2AddGrade1() {
    let add_e0_e0:[(Double, [e])] = [e(0)] |+| e(0)
    XCTAssertEqual(add_e0_e0.first!.0, 2)
    XCTAssertEqual(add_e0_e0.first!.1.count, 1)
    XCTAssertEqual(add_e0_e0.first!.1.first!, e(0))
    
    let add_e0_e0_rev:[(Double, [e])] = e(0) |+| [e(0)]
    XCTAssertEqual(add_e0_e0_rev.first!.0, 2)
    XCTAssertEqual(add_e0_e0_rev.first!.1.count, 1)
    XCTAssertEqual(add_e0_e0_rev.first!.1.first!, e(0))
    
    let add_1e0_2e0:[(Double, [e])] = (1, [e(0)]) |+| (2, e(0))
    XCTAssertEqual(add_1e0_2e0.first!.0, 1+2)
    XCTAssertEqual(add_1e0_2e0.first!.1.first!, e(0))
    
    let add_1e0_2e0_rev:[(Double, [e])] = (2, e(0)) |+| (1, [e(0)])
    XCTAssertEqual(add_1e0_2e0_rev.first!.0, 1+2)
    XCTAssertEqual(add_1e0_2e0_rev.first!.1.first!, e(0))
    
    let add_e1_e1:[(Double, [e])] = [e(1)] |+| e(1)
    XCTAssertEqual(add_e1_e1.first!.0, 2)
    XCTAssertEqual(add_e1_e1.first!.1.count, 1)
    XCTAssertEqual(add_e1_e1.first!.1.first!, e(1))
    
    let add_e1_e1_rev:[(Double, [e])] = e(1) |+| [e(1)]
    XCTAssertEqual(add_e1_e1_rev.first!.0, 2)
    XCTAssertEqual(add_e1_e1_rev.first!.1.count, 1)
    XCTAssertEqual(add_e1_e1_rev.first!.1.first!, e(1))
    
    let add_2e1_5e1:[(Double, [e])] = (2, [e(1)]) |+| (5, e(1))
    XCTAssertEqual(add_2e1_5e1.first!.0, 2+5)
    XCTAssertEqual(add_2e1_5e1.first!.1.count, 1)
    XCTAssertEqual(add_2e1_5e1.first!.1.first!, e(1))
    
    let add_2e1_5e1_rev:[(Double, [e])] = (5, e(1)) |+| (2, [e(1)])
    XCTAssertEqual(add_2e1_5e1_rev.first!.0, 2+5)
    XCTAssertEqual(add_2e1_5e1_rev.first!.1.count, 1)
    XCTAssertEqual(add_2e1_5e1_rev.first!.1.first!, e(1))
    
    let add_e2_e2:[(Double, [e])] = [e(2)] |+| e(2)
    XCTAssertEqual(add_e2_e2.first!.0, 2)
    XCTAssertEqual(add_e2_e2.first!.1.count, 1)
    XCTAssertEqual(add_e2_e2.first!.1.first!, e(2))
    
    let add_e2_e2_rev:[(Double, [e])] = e(2) |+| [e(2)]
    XCTAssertEqual(add_e2_e2_rev.first!.0, 2)
    XCTAssertEqual(add_e2_e2_rev.first!.1.count, 1)
    XCTAssertEqual(add_e2_e2_rev.first!.1.first!, e(2))
    
    let add_7e2_4e2:[(Double, [e])] = (7, [e(2)]) |+| (4, e(2))
    XCTAssertEqual(add_7e2_4e2.first!.0, 7+4)
    XCTAssertEqual(add_7e2_4e2.first!.1.count, 1)
    XCTAssertEqual(add_7e2_4e2.first!.1.first!, e(2))
    
    let add_7e2_4e2_rev:[(Double, [e])] = (4, e(2)) |+| (7, [e(2)])
    XCTAssertEqual(add_7e2_4e2_rev.first!.0, 7+4)
    XCTAssertEqual(add_7e2_4e2_rev.first!.1.count, 1)
    XCTAssertEqual(add_7e2_4e2_rev.first!.1.first!, e(2))
    
    let add_e3_e3:[(Double, [e])] = [e(3)] |+| e(3)
    XCTAssertEqual(add_e3_e3.first!.0, 2)
    XCTAssertEqual(add_e3_e3.first!.1.count, 1)
    XCTAssertEqual(add_e3_e3.first!.1.first!, e(3))
    
    let add_e3_e3_rev:[(Double, [e])] = e(3) |+| [e(3)]
    XCTAssertEqual(add_e3_e3_rev.first!.0, 2)
    XCTAssertEqual(add_e3_e3_rev.first!.1.count, 1)
    XCTAssertEqual(add_e3_e3_rev.first!.1.first!, e(3))
    
    let add_4e3_7e3:[(Double, [e])] = (4, e(3)) |+| (7, [e(3)])
    XCTAssertEqual(add_4e3_7e3.first!.0, 4+7)
    XCTAssertEqual(add_4e3_7e3.first!.1.count, 1)
    XCTAssertEqual(add_4e3_7e3.first!.1.first!, e(3))
    
    let add_4e3_7e3_rev:[(Double, [e])] = (7, [e(3)]) |+| (4, e(3))
    XCTAssertEqual(add_4e3_7e3_rev.first!.0, 4+7)
    XCTAssertEqual(add_4e3_7e3_rev.first!.1.count, 1)
    XCTAssertEqual(add_4e3_7e3_rev.first!.1.first!, e(3))
    
    let add_e0_e1:[(Double, [e])] = e(0) |+| [e(1)]
    XCTAssertEqual(add_e0_e1.count, 2)
    XCTAssertEqual(add_e0_e1.first!.0, 1)
    XCTAssertEqual(add_e0_e1.first!.1.first!, e(0))
    
    let add_e0_e1_rev:[(Double, [e])] = [e(1)] |+| e(0)
    XCTAssertEqual(add_e0_e1_rev.count, 2)
    XCTAssertEqual(add_e0_e1_rev.first!.0, 1)
    XCTAssertEqual(add_e0_e1_rev.first!.1.first!, e(1))
    XCTAssertEqual(add_e0_e1_rev.last!.1.first!, e(0))
    
    let add_4e0_6e1:[(Double, [e])] = (4, e(0)) |+| (6, [e(1)])
    XCTAssertEqual(add_4e0_6e1.count, 2)
    XCTAssertEqual(add_4e0_6e1.first!.0, 4)
    XCTAssertEqual(add_4e0_6e1.first!.1.first!, e(0))
    XCTAssertEqual(add_4e0_6e1.last!.0, 6)
    XCTAssertEqual(add_4e0_6e1.last!.1.first!, e(1))
    
    let add_4e0_6e1_rev:[(Double, [e])] = (6, [e(1)]) |+| (4, e(0))
    XCTAssertEqual(add_4e0_6e1_rev.count, 2)
    XCTAssertEqual(add_4e0_6e1_rev.first!.0, 6)
    XCTAssertEqual(add_4e0_6e1_rev.first!.1.first!, e(1))
    XCTAssertEqual(add_4e0_6e1_rev.last!.0, 4)
    XCTAssertEqual(add_4e0_6e1_rev.last!.1.first!, e(0))
    
    let add_e1_e2:[(Double, [e])] = e(1) |+| [e(2)]
    XCTAssertEqual(add_e1_e2.count, 2)
    XCTAssertEqual(add_e1_e2.first!.0, 1)
    XCTAssertEqual(add_e1_e2.first!.1.first!, e(1))
    XCTAssertEqual(add_e1_e2.last!.0, 1)
    XCTAssertEqual(add_e1_e2.last!.1.first!, e(2))
    
    let add_e1_e2_rev:[(Double, [e])] = [e(2)] |+| e(1)
    XCTAssertEqual(add_e1_e2_rev.count, 2)
    XCTAssertEqual(add_e1_e2_rev.first!.0, 1)
    XCTAssertEqual(add_e1_e2_rev.first!.1.first!, e(2))
    XCTAssertEqual(add_e1_e2_rev.last!.0, 1)
    XCTAssertEqual(add_e1_e2_rev.last!.1.first!, e(1))
    
    let add_1e1_2e2:[(Double, [e])] = (1, e(1)) |+| (2, [e(2)])
    XCTAssertEqual(add_1e1_2e2.count, 2)
    XCTAssertEqual(add_1e1_2e2.first!.0, 1)
    XCTAssertEqual(add_1e1_2e2.first!.1.first!, e(1))
    XCTAssertEqual(add_1e1_2e2.last!.0, 2)
    XCTAssertEqual(add_1e1_2e2.last!.1.first!, e(2))
    
    let add_1e1_2e2_rev:[(Double, [e])] = (2, [e(2)]) |+| (1, e(1))
    XCTAssertEqual(add_1e1_2e2_rev.count, 2)
    XCTAssertEqual(add_1e1_2e2_rev.first!.0, 2)
    XCTAssertEqual(add_1e1_2e2_rev.first!.1.first!, e(2))
    XCTAssertEqual(add_1e1_2e2_rev.last!.0, 1)
    XCTAssertEqual(add_1e1_2e2_rev.last!.1.first!, e(1))
    
      // Commutativity wrt addition.
    let add_e2_e1:[(Double, [e])] = e(2) |+| [e(1)]
    XCTAssertEqual(add_e2_e1.count, 2)
    XCTAssertEqual(add_e2_e1.first!.0, add_e1_e2.last!.0)
    XCTAssertEqual(add_e2_e1.last!.1,  add_e1_e2.first!.1)
    
    let add_e2_e1_rev:[(Double, [e])] = [e(1)] |+| e(2)
    XCTAssertEqual(add_e2_e1_rev.count, 2)
    XCTAssertEqual(add_e2_e1_rev.first!.0, add_e1_e2_rev.last!.0)
    XCTAssertEqual(add_e2_e1_rev.last!.1,  add_e1_e2_rev.first!.1)
    
    let add_2e2_1e1:[(Double, [e])] = (2, e(2)) |+| (1, [e(1)])
    XCTAssertEqual(add_2e2_1e1.count, 2)
    XCTAssertEqual(add_2e2_1e1.first!.0, add_1e1_2e2.last!.0)
    XCTAssertEqual(add_2e2_1e1.last!.1,  add_1e1_2e2.first!.1)
    
    let add_2e2_1e1_rev:[(Double, [e])] = (1, [e(1)]) |+| (2, e(2))
    XCTAssertEqual(add_2e2_1e1_rev.count, 2)
    XCTAssertEqual(add_2e2_1e1_rev.first!.0, add_1e1_2e2_rev.last!.0)
    XCTAssertEqual(add_2e2_1e1_rev.last!.1,  add_1e1_2e2_rev.first!.1)
    
    let add_1e01_2e1:[(Double, [e])] = (1, [e(0), e(1)]) |+| (2, e(1))
    XCTAssertEqual(add_1e01_2e1.count, 2)
    XCTAssertEqual(add_1e01_2e1.first!.1.count, 1)
    XCTAssertEqual(add_1e01_2e1.last!.1.count, 2)
    XCTAssertEqual(add_1e01_2e1.first!.0, 2)
    XCTAssertEqual(add_1e01_2e1.first!.1, [e(1)])
    XCTAssertEqual(add_1e01_2e1.last!.0, 1)
    XCTAssertEqual(add_1e01_2e1.last!.1, [e(0), e(1)])
    
    let add_1e01_2e1_rev:[(Double, [e])] = (2, e(1)) |+| (1, [e(0), e(1)])
    XCTAssertEqual(add_1e01_2e1_rev.count, 2)
    XCTAssertEqual(add_1e01_2e1_rev.first!.1.count, 1)
    XCTAssertEqual(add_1e01_2e1_rev.last!.1.count, 2)
    XCTAssertEqual(add_1e01_2e1_rev.first!.0, 2)
    XCTAssertEqual(add_1e01_2e1_rev.first!.1, [e(1)])
    XCTAssertEqual(add_1e01_2e1_rev.last!.0, 1)
    XCTAssertEqual(add_1e01_2e1_rev.last!.1, [e(0), e(1)])
  }
  
  func testGrade2AddGrade2() {
    let add_e0_e0:[(Double, [e])] = [e(0)] |+| [e(0)]
    XCTAssertEqual(add_e0_e0.first!.0, 2)
    XCTAssertEqual(add_e0_e0.first!.1.count, 1)
    XCTAssertEqual(add_e0_e0.first!.1.first!, e(0))
    
    let add_1e0_2e0:[(Double, [e])] = (1, [e(0)]) |+| (2, [e(0)])
    XCTAssertEqual(add_1e0_2e0.first!.0, 1+2)
    XCTAssertEqual(add_1e0_2e0.first!.1.first!, e(0))
    
    let add_e1_e1:[(Double, [e])] = [e(1)] |+| [e(1)]
    XCTAssertEqual(add_e1_e1.first!.0, 2)
    XCTAssertEqual(add_e1_e1.first!.1.count, 1)
    XCTAssertEqual(add_e1_e1.first!.1.first!, e(1))
    
    let add_2e1_5e1:[(Double, [e])] = (2, [e(1)]) |+| (5, [e(1)])
    XCTAssertEqual(add_2e1_5e1.first!.0, 2+5)
    XCTAssertEqual(add_2e1_5e1.first!.1.count, 1)
    XCTAssertEqual(add_2e1_5e1.first!.1.first!, e(1))
    
    let add_e2_e2:[(Double, [e])] = [e(2)] |+| [e(2)]
    XCTAssertEqual(add_e2_e2.first!.0, 2)
    XCTAssertEqual(add_e2_e2.first!.1.count, 1)
    XCTAssertEqual(add_e2_e2.first!.1.first!, e(2))
    
    let add_7e2_4e2:[(Double, [e])] = (7, [e(2)]) |+| (4, [e(2)])
    XCTAssertEqual(add_7e2_4e2.first!.0, 7+4)
    XCTAssertEqual(add_7e2_4e2.first!.1.count, 1)
    XCTAssertEqual(add_7e2_4e2.first!.1.first!, e(2))

    let add_e3_e3:[(Double, [e])] = [e(3)] |+| [e(3)]
    XCTAssertEqual(add_e3_e3.first!.0, 2)
    XCTAssertEqual(add_e3_e3.first!.1.count, 1)
    XCTAssertEqual(add_e3_e3.first!.1.first!, e(3))
    
    let add_4e3_7e3:[(Double, [e])] = (4, [e(3)]) |+| (7, [e(3)])
    XCTAssertEqual(add_4e3_7e3.first!.0, 4+7)
    XCTAssertEqual(add_4e3_7e3.first!.1.count, 1)
    XCTAssertEqual(add_4e3_7e3.first!.1.first!, e(3))
    
    let add_e0_e1:[(Double, [e])] = [e(0)] |+| [e(1)]
    XCTAssertEqual(add_e0_e1.count, 2)
    XCTAssertEqual(add_e0_e1.first!.0, 1)
    XCTAssertEqual(add_e0_e1.first!.1.first!, e(0))
    
    let add_4e0_6e1:[(Double, [e])] = (4, [e(0)]) |+| (6, [e(1)])
    XCTAssertEqual(add_4e0_6e1.count, 2)
    XCTAssertEqual(add_4e0_6e1.first!.0, 4)
    XCTAssertEqual(add_4e0_6e1.first!.1.first!, e(0))
    XCTAssertEqual(add_4e0_6e1.last!.0, 6)
    XCTAssertEqual(add_4e0_6e1.last!.1.first!, e(1))
    
    let add_e1_e2:[(Double, [e])] = [e(1)] |+| [e(2)]
    XCTAssertEqual(add_e1_e2.count, 2)
    XCTAssertEqual(add_e1_e2.first!.0, 1)
    XCTAssertEqual(add_e1_e2.first!.1.first!, e(1))
    XCTAssertEqual(add_e1_e2.last!.0, 1)
    XCTAssertEqual(add_e1_e2.last!.1.first!, e(2))
    
    let add_1e1_2e2:[(Double, [e])] = (1, [e(1)]) |+| (2, [e(2)])
    XCTAssertEqual(add_1e1_2e2.count, 2)
    XCTAssertEqual(add_1e1_2e2.first!.0, 1)
    XCTAssertEqual(add_1e1_2e2.first!.1.first!, e(1))
    XCTAssertEqual(add_1e1_2e2.last!.0, 2)
    XCTAssertEqual(add_1e1_2e2.last!.1.first!, e(2))
    
    // Commutativity wrt addition.
    let add_e2_e1:[(Double, [e])] = [e(2)] |+| [e(1)]
    XCTAssertEqual(add_e2_e1.count, 2)
    XCTAssertEqual(add_e2_e1.first!.0, add_e1_e2.last!.0)
    XCTAssertEqual(add_e2_e1.last!.1,  add_e1_e2.first!.1)
    
    let add_2e2_1e1:[(Double, [e])] = (2, [e(2)]) |+| (1, [e(1)])
    XCTAssertEqual(add_2e2_1e1.count, 2)
    XCTAssertEqual(add_2e2_1e1.first!.0, add_1e1_2e2.last!.0)
    XCTAssertEqual(add_2e2_1e1.last!.1,  add_1e1_2e2.first!.1)
    
    let add_1e01_2e1:[(Double, [e])] = (1, [e(0), e(1)]) |+| (2, [e(1)])
    XCTAssertEqual(add_1e01_2e1.count, 2)
    XCTAssertEqual(add_1e01_2e1.first!.1.count, 1)
    XCTAssertEqual(add_1e01_2e1.last!.1.count, 2)
    XCTAssertEqual(add_1e01_2e1.first!.0, 2)
    XCTAssertEqual(add_1e01_2e1.first!.1, [e(1)])
    XCTAssertEqual(add_1e01_2e1.last!.0, 1)
    XCTAssertEqual(add_1e01_2e1.last!.1, [e(0), e(1)])
    
    let add_1e01_2e01:[(Double, [e])] = (1, [e(0), e(1)]) |+| (2, [e(0), e(1)])
    XCTAssertEqual(add_1e01_2e01.count, 1)
    XCTAssertEqual(add_1e01_2e01.first!.1.count, 2)
    XCTAssertEqual(add_1e01_2e01.first!.0, 3)
    XCTAssertEqual(add_1e01_2e01.first!.1, [e(0), e(1)])
    
    let add_1e01_2e10:[(Double, [e])] = (1, [e(0), e(1)]) |+| (2, [e(1), e(0)])
    XCTAssertEqual(add_1e01_2e10.count, 1)
    XCTAssertEqual(add_1e01_2e10.first!.1.count, 2)
    XCTAssertEqual(add_1e01_2e10.first!.0, -1)
    XCTAssertEqual(add_1e01_2e10.first!.1, [e(0), e(1)])
    
    let add_1e01_2e23:[(Double, [e])] = (1, [e(0), e(1)]) |+| (2, [e(2), e(3)])
    XCTAssertEqual(add_1e01_2e23.count, 2)
    XCTAssertEqual(add_1e01_2e23.first!.1.count, 2)
    XCTAssertEqual(add_1e01_2e23.last!.1.count, 2)
    XCTAssertEqual(add_1e01_2e23.first!.0, 1)
    XCTAssertEqual(add_1e01_2e23.first!.1, [e(0), e(1)])
    XCTAssertEqual(add_1e01_2e23.last!.0, 2)
    XCTAssertEqual(add_1e01_2e23.last!.1, [e(2), e(3)])
    
    let add_2e23_1e01:[(Double, [e])] = (2, [e(2), e(3)]) |+| (1, [e(0), e(1)])
    XCTAssertEqual(add_2e23_1e01.count, 2)
    XCTAssertEqual(add_2e23_1e01.first!.1.count, 2)
    XCTAssertEqual(add_2e23_1e01.last!.1.count, 2)
    XCTAssertEqual(add_2e23_1e01.first!.0, 2)
    XCTAssertEqual(add_2e23_1e01.first!.1, [e(2), e(3)] )
    XCTAssertEqual(add_2e23_1e01.last!.0, 1)
    XCTAssertEqual(add_2e23_1e01.last!.1, [e(0), e(1)])
    
  }
  
  func testScalarOuterProdGrade1() {
    let e2 = e(2) |^| 22
    XCTAssertEqual(e2.0, 22)
    XCTAssertEqual(e2.1, e(2))
    
    let e3 =  22 |^| e(3)
    XCTAssertEqual(e3.0, 22)
    XCTAssertEqual(e3.1, e(3))
  }
  
  func testGrade1OuterProdGrade1WithCoefficents() {
    let outer_e0:(Double, [e]) = (1, e(0)) |^| (1, e(0))
    XCTAssertEqual(outer_e0.0, 0)
    
    let outer_10e0:(Double, [e]) = (10, e(0)) |^| (10, e(0))
    XCTAssertEqual(outer_10e0.0, 0)
    XCTAssertEqual(outer_10e0.1.first, nil)
    
    let outer_10e1_2e1:(Double, [e]) = (10, e(1)) |^| (2, e(1))
    XCTAssertEqual(outer_10e1_2e1.0, 20)
    XCTAssertEqual(outer_10e1_2e1.1.first, nil)
    
    let outer_5e2_2e2:(Double, [e]) = (5, e(2)) |^| (2, e(2))
    XCTAssertEqual(outer_5e2_2e2.0, 10)
    XCTAssertEqual(outer_5e2_2e2.1.first, nil)
    
    let outer_5e1_2e2:(Double, [e]) = (5, e(1)) |^| (2, e(2))
    XCTAssertEqual(outer_5e1_2e2.0, 10)
    XCTAssertEqual(outer_5e1_2e2.1, [e(1),e(2)])
    
    let outer_5e2_2e1:(Double, [e]) = (5, e(2)) |^| (2, e(1))
    XCTAssertEqual(outer_5e2_2e1.0, -10)
    XCTAssertEqual(outer_5e2_2e1.1, [e(1),e(2)])
  }
  
  func testGrade2OuterProdGrade1() {
    let outer_1e0_1e0:(Double, [e]) = (1, [e(0)]) |^| (1, e(0))
    XCTAssert(outer_1e0_1e0.1.isEmpty)
    XCTAssertEqual(outer_1e0_1e0.0, 0)
    
    let outer_1e0_1e0_rev:(Double, [e]) = (1, e(0)) |^| (1, [e(0)])
    XCTAssert(outer_1e0_1e0_rev.1.isEmpty)
    XCTAssertEqual(outer_1e0_1e0_rev.0, 0)
    
    let outer_1e1_1e1:(Double, [e]) = (1, [e(1)]) |^| (1, e(1))
    XCTAssert(outer_1e1_1e1.1.isEmpty)
    XCTAssertEqual(outer_1e1_1e1.0, 0)
    
    let outer_1e1_1e1_rev:(Double, [e]) = (1, e(1)) |^| (1, [e(1)])
    XCTAssert(outer_1e1_1e1_rev.1.isEmpty)
    XCTAssertEqual(outer_1e1_1e1_rev.0, 0)
    
    let outer_1e01_1e1:(Double, [e]) = (1, [e(0),e(1)]) |^| (1, e(1))
    XCTAssert(outer_1e01_1e1.1.isEmpty)
    XCTAssertEqual(outer_1e01_1e1.0, 0)
    
    let outer_1e01_1e1_rev:(Double, [e]) = (1, e(1)) |^| (1, [e(0),e(1)])
    XCTAssert(outer_1e01_1e1_rev.1.isEmpty)
    XCTAssertEqual(outer_1e01_1e1_rev.0, 0)
    
    let outer_1e12_1e1:(Double, [e]) = (1, [e(1),e(2)]) |^| (1, e(1))
    XCTAssert(outer_1e12_1e1.1.isEmpty)
    XCTAssertEqual(outer_1e12_1e1.0, 0)
    
    let outer_1e12_1e1_rev:(Double, [e]) = (1, e(1)) |^| (1, [e(1),e(2)])
    XCTAssert(outer_1e12_1e1_rev.1.isEmpty)
    XCTAssertEqual(outer_1e12_1e1_rev.0, 0)
    
    let outer_1e1_1e12:(Double, [e]) = (1, e(1)) |^| (1,[e(1),e(2)])
    XCTAssert(outer_1e1_1e12.1.isEmpty)
    XCTAssertEqual(outer_1e1_1e12.0, 0)
    
    let outer_1e1_1e12_rev:(Double, [e]) = (1,[e(1),e(2)]) |^| (1, e(1))
    XCTAssert(outer_1e1_1e12_rev.1.isEmpty)
    XCTAssertEqual(outer_1e1_1e12_rev.0, 0)
    
    let outer_1e1_1e21:(Double, [e]) = (1, e(1)) |^| (1,[e(2),e(1)])
    XCTAssert(outer_1e1_1e21.1.isEmpty)
    XCTAssertEqual(outer_1e1_1e21.0, 0)
    
    let outer_1e1_1e21_rev:(Double, [e]) = (1,[e(2),e(1)]) |^| (1, e(1))
    XCTAssert(outer_1e1_1e21_rev.1.isEmpty)
    XCTAssertEqual(outer_1e1_1e21_rev.0, 0)
    
    let outer_1e0_1e12:(Double, [e]) = (1, e(0)) |^| (1,[e(1),e(2)])
    XCTAssert(!outer_1e0_1e12.1.isEmpty)
    XCTAssertEqual(outer_1e0_1e12.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_1e0_1e12.0, 1)
    
    let outer_1e0_1e12_rev:(Double, [e]) = (1,[e(1),e(2)]) |^| (1, e(0))
    XCTAssert(!outer_1e0_1e12_rev.1.isEmpty)
    XCTAssertEqual(outer_1e0_1e12_rev.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_1e0_1e12_rev.0, 1)
    
    let outer_2e0_5e12:(Double, [e]) = (2, e(0)) |^| (5,[e(1),e(2)])
    XCTAssert(!outer_1e0_1e12.1.isEmpty)
    XCTAssertEqual(outer_2e0_5e12.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_2e0_5e12.0, 10)
    
    let outer_2e0_5e12_rev:(Double, [e]) = (5,[e(1),e(2)]) |^| (2, e(0))
    XCTAssert(!outer_2e0_5e12_rev.1.isEmpty)
    XCTAssertEqual(outer_2e0_5e12_rev.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_2e0_5e12_rev.0, 10)
    
    let outer_2e10_5e2:(Double, [e]) = (2, [e(1),e(0)]) |^| (5, e(2))
    XCTAssert(!outer_2e10_5e2.1.isEmpty)
    XCTAssertEqual(outer_2e10_5e2.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_2e10_5e2.0, -10)
    
    let outer_2e10_5e2_rev:(Double, [e]) = (5, e(2)) |^| (2, [e(1),e(0)])
    XCTAssert(!outer_2e10_5e2_rev.1.isEmpty)
    XCTAssertEqual(outer_2e10_5e2_rev.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_2e10_5e2_rev.0, -10)
    
    let outer_2e320_5e1:(Double, [e]) = (2, [e(3),e(2),e(0)]) |^| (5, e(1))
    XCTAssert(!outer_2e320_5e1.1.isEmpty)
    XCTAssertEqual(outer_2e320_5e1.1, [e(0), e(1), e(2), e(3)])
    XCTAssertEqual(outer_2e320_5e1.0, -10)
    
    let outer_2e320_5e1_rev:(Double, [e]) = (5, e(1)) |^| (2, [e(3),e(2),e(0)])
    XCTAssert(!outer_2e320_5e1_rev.1.isEmpty)
    XCTAssertEqual(outer_2e320_5e1_rev.1, [e(0), e(1), e(2), e(3)])
    XCTAssertEqual(outer_2e320_5e1_rev.0, 10)
  }
  
  func testGrade2OuterProdGrade2() {
    let outer_1e0_1e0:(Double, [e]) = (1, [e(0)]) |^| (1, [e(0)])
    XCTAssert(outer_1e0_1e0.1.isEmpty)
    XCTAssertEqual(outer_1e0_1e0.0, 0)
    
    let outer_1e1_1e1:(Double, [e]) = (1, [e(1)]) |^| (1, [e(1)])
    XCTAssert(outer_1e1_1e1.1.isEmpty)
    XCTAssertEqual(outer_1e1_1e1.0, 0)
    
    let outer_1e01_1e1:(Double, [e]) = (1, [e(0),e(1)]) |^| (1, [e(1)])
    XCTAssert(outer_1e01_1e1.1.isEmpty)
    XCTAssertEqual(outer_1e01_1e1.0, 0)
    
    let outer_1e12_1e1:(Double, [e]) = (1, [e(1),e(2)]) |^| (1, [e(1)])
    XCTAssert(outer_1e12_1e1.1.isEmpty)
    XCTAssertEqual(outer_1e12_1e1.0, 0)
    
    let outer_1e1_1e12:(Double, [e]) = (1, [e(1)]) |^| (1,[e(1),e(2)])
    XCTAssert(outer_1e1_1e12.1.isEmpty)
    XCTAssertEqual(outer_1e1_1e12.0, 0)
    
    let outer_1e1_1e21:(Double, [e]) = (1, [e(1)]) |^| (1,[e(2),e(1)])
    XCTAssert(outer_1e1_1e21.1.isEmpty)
    XCTAssertEqual(outer_1e1_1e21.0, 0)
    
    let outer_1e0_1e12:(Double, [e]) = (1, [e(0)]) |^| (1,[e(1),e(2)])
    XCTAssert(!outer_1e0_1e12.1.isEmpty)
    XCTAssertEqual(outer_1e0_1e12.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_1e0_1e12.0, 1)
    
    let outer_2e0_5e12:(Double, [e]) = (2, [e(0)]) |^| (5,[e(1),e(2)])
    XCTAssert(!outer_1e0_1e12.1.isEmpty)
    XCTAssertEqual(outer_2e0_5e12.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_2e0_5e12.0, 10)
    
    let outer_2e10_5e2:(Double, [e]) = (2, [e(1),e(0)]) |^| (5, [e(2)])
    XCTAssert(!outer_2e10_5e2.1.isEmpty)
    XCTAssertEqual(outer_2e10_5e2.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_2e10_5e2.0, -10)
    
    let outer_2e32_5e01:(Double, [e]) = (2, [e(3),e(2)]) |^| (5, [e(0), e(1)])
    XCTAssert(!outer_2e32_5e01.1.isEmpty)
    XCTAssertEqual(outer_2e32_5e01.1, [e(0), e(1), e(2), e(3)])
    XCTAssertEqual(outer_2e32_5e01.0, -10)
    
    let outer_2e320_5e1:(Double, [e]) = (2, [e(3),e(2),e(0)]) |^| (5, [e(1)])
    XCTAssert(!outer_2e320_5e1.1.isEmpty)
    XCTAssertEqual(outer_2e320_5e1.1, [e(0), e(1), e(2), e(3)])
    XCTAssertEqual(outer_2e320_5e1.0, -10)
  }
  
  func testScalarInnerProdGrade1() {
    let e0 = 10 ||| e(0)
    XCTAssertEqual(e0.0, 10)
    XCTAssertEqual(e0.1, e(0))
    
    let e1 = e(1) ||| 22
    XCTAssertEqual(e1.0, 22)
    XCTAssertEqual(e1.1, e(1))
  }
  
  func testGrade1InnerProdGrade1WithCoefficents() {
    let inner_e0:Double = (1, e(0)) ||| (1, e(0))
    XCTAssertEqual(inner_e0, 0)
    
    let inner_e1:Double = (3, e(1)) ||| (4, e(1))
    XCTAssertEqual(inner_e1, 12)
    
    let inner_e2:Double = (2, e(2)) ||| (2, e(2))
    XCTAssertEqual(inner_e2, 4)
    
    let inner_e12:Double = (1, e(1)) ||| (2, e(2))
    XCTAssertEqual(inner_e12, 0)
  }
  
  func testGrade2InnerProdGrade1() {
    let inner_1e0_1e0:(Double, [e]) = (1, [e(0)]) ||| (1, e(0))
    XCTAssertEqual(inner_1e0_1e0.0, 0)
    XCTAssert(inner_1e0_1e0.1.isEmpty)
    
    let inner_1e0_1e0_rev:(Double, [e]) = (1, e(0)) ||| (1, [e(0)])
    XCTAssertEqual(inner_1e0_1e0_rev.0, 0)
    XCTAssert(inner_1e0_1e0_rev.1.isEmpty)
    
    let inner_1e1_1e1:(Double, [e]) = (1, [e(1)]) ||| (1, e(1))
    XCTAssertEqual(inner_1e1_1e1.0, 1)
    XCTAssert(inner_1e1_1e1.1.isEmpty)
    
    let inner_1e1_1e1_rev:(Double, [e]) = (1, e(1)) ||| (1, [e(1)])
    XCTAssertEqual(inner_1e1_1e1_rev.0, 1)
    XCTAssert(inner_1e1_1e1_rev.1.isEmpty)
    
    let inner_1e01_1e1:(Double, [e]) = (1, [e(0),e(1)]) ||| (1, e(1))
    XCTAssertEqual(inner_1e01_1e1.0, 1)
    XCTAssert(!inner_1e01_1e1.1.isEmpty)
    XCTAssertEqual(inner_1e01_1e1.1, [e(0)])
    
    let inner_1e01_1e1_rev:(Double, [e]) = (1, e(1)) ||| (1, [e(0),e(1)])
    XCTAssertEqual(inner_1e01_1e1_rev.0, -1)
    XCTAssert(!inner_1e01_1e1_rev.1.isEmpty)
    XCTAssertEqual(inner_1e01_1e1_rev.1, [e(0)])
    
    let inner_1e12_1e1:(Double, [e]) = (1, [e(1),e(2)]) ||| (1, e(1))
    XCTAssertEqual(inner_1e12_1e1.0, -1)
    XCTAssert(!inner_1e12_1e1.1.isEmpty)
    XCTAssertEqual(inner_1e12_1e1.1, [e(2)])
    
    let inner_1e12_1e1_rev:(Double, [e]) = (1, e(1)) ||| (1, [e(1),e(2)])
    XCTAssertEqual(inner_1e12_1e1_rev.0, 1)
    XCTAssert(!inner_1e12_1e1_rev.1.isEmpty)
    XCTAssertEqual(inner_1e12_1e1_rev.1, [e(2)])
    
    let inner_1e1_1e12:(Double, [e]) = (1, e(1)) ||| (1,[e(1),e(2)])
    XCTAssertEqual(inner_1e1_1e12.0, 1)
    XCTAssert(!inner_1e1_1e12.1.isEmpty)
    XCTAssertEqual(inner_1e1_1e12.1, [e(2)])
    
    let inner_1e1_1e12_rev:(Double, [e]) = (1,[e(1),e(2)]) ||| (1, e(1))
    XCTAssertEqual(inner_1e1_1e12_rev.0, -1)
    XCTAssert(!inner_1e1_1e12_rev.1.isEmpty)
    XCTAssertEqual(inner_1e1_1e12_rev.1, [e(2)])
    
    let inner_1e1_1e21:(Double, [e]) = (1, e(1)) ||| (1,[e(2),e(1)])
    XCTAssertEqual(inner_1e1_1e21.0, -1)
    XCTAssert(!inner_1e1_1e21.1.isEmpty)
    XCTAssertEqual(inner_1e1_1e21.1, [e(2)])
    
    let inner_1e1_1e21_rev:(Double, [e]) = (1,[e(2),e(1)]) ||| (1, e(1))
    XCTAssertEqual(inner_1e1_1e21_rev.0, 1)
    XCTAssert(!inner_1e1_1e21_rev.1.isEmpty)
    XCTAssertEqual(inner_1e1_1e21_rev.1, [e(2)])
    
    let inner_1e0_1e12:(Double, [e]) = (1, e(0)) ||| (1,[e(1),e(2)])
    XCTAssert(inner_1e0_1e12.1.isEmpty)
    XCTAssertEqual(inner_1e0_1e12.0, 0)
    
    let inner_1e0_1e12_rev:(Double, [e]) = (1,[e(1),e(2)]) ||| (1, e(0))
    XCTAssert(inner_1e0_1e12_rev.1.isEmpty)
    XCTAssertEqual(inner_1e0_1e12_rev.0, 0)
    
    let inner_2e0_5e12:(Double, [e]) = (2, e(0)) ||| (5,[e(1),e(2)])
    XCTAssert(inner_1e0_1e12.1.isEmpty)
    XCTAssertEqual(inner_2e0_5e12.0, 0)
    
    let inner_2e0_5e12_rev:(Double, [e]) = (5,[e(1),e(2)]) ||| (2, e(0))
    XCTAssert(inner_2e0_5e12_rev.1.isEmpty)
    XCTAssertEqual(inner_2e0_5e12_rev.0, 0)
    
    let inner_2e10_5e2:(Double, [e]) = (2, [e(1),e(0)]) ||| (5, e(2))
    XCTAssert(inner_2e10_5e2.1.isEmpty)
    XCTAssertEqual(inner_2e10_5e2.0, 0)
    
    let inner_2e10_5e2_rev:(Double, [e]) = (5, e(2)) ||| (2, [e(1),e(0)])
    XCTAssert(inner_2e10_5e2_rev.1.isEmpty)
    XCTAssertEqual(inner_2e10_5e2_rev.0, 0)
    
    
    let inner_2e320_5e1:(Double, [e]) = (2, [e(3),e(2),e(0)]) ||| (5, e(1))
    XCTAssert(inner_2e320_5e1.1.isEmpty)
    XCTAssertEqual(inner_2e320_5e1.0, 0)
    
    let inner_2e320_5e1_rev:(Double, [e]) = (5, e(1)) ||| (2, [e(3),e(2),e(0)])
    XCTAssert(inner_2e320_5e1_rev.1.isEmpty)
    XCTAssertEqual(inner_2e320_5e1_rev.0, 0)
  }
  
  func testGrade2InnerProdGrade2() {
    let inner_1e0_1e0:(Double, [e]) = (1, [e(0)]) ||| (1, [e(0)])
    XCTAssertEqual(inner_1e0_1e0.0, 0)
    XCTAssert(inner_1e0_1e0.1.isEmpty)
    
    let inner_1e1_1e1:(Double, [e]) = (1, [e(1)]) ||| (1, [e(1)])
    XCTAssertEqual(inner_1e1_1e1.0, 1)
    XCTAssert(inner_1e1_1e1.1.isEmpty)
    
    let inner_1e01_1e1:(Double, [e]) = (1, [e(0),e(1)]) ||| (1, [e(1)])
    XCTAssertEqual(inner_1e01_1e1.0, 1)
    XCTAssert(!inner_1e01_1e1.1.isEmpty)
    XCTAssertEqual(inner_1e01_1e1.1, [e(0)])
    
    let inner_1e12_1e1:(Double, [e]) = (1, [e(1),e(2)]) ||| (1, [e(1)])
    XCTAssertEqual(inner_1e12_1e1.0, -1)
    XCTAssert(!inner_1e12_1e1.1.isEmpty)
    XCTAssertEqual(inner_1e12_1e1.1, [e(2)])
    
    let inner_1e1_1e12:(Double, [e]) = (1, [e(1)]) ||| (1,[e(1),e(2)])
    XCTAssertEqual(inner_1e1_1e12.0, 1)
    XCTAssert(!inner_1e1_1e12.1.isEmpty)
    XCTAssertEqual(inner_1e1_1e12.1, [e(2)])
    
    let inner_1e1_1e21:(Double, [e]) = (1, [e(1)]) ||| (1,[e(2),e(1)])
    XCTAssertEqual(inner_1e1_1e21.0, -1)
    XCTAssert(!inner_1e1_1e21.1.isEmpty)
    XCTAssertEqual(inner_1e1_1e21.1, [e(2)])
    
    let inner_1e0_1e12:(Double, [e]) = (1, [e(0)]) ||| (1,[e(1),e(2)])
    XCTAssert(inner_1e0_1e12.1.isEmpty)
    XCTAssertEqual(inner_1e0_1e12.0, 0)
    
    let inner_2e0_5e12:(Double, [e]) = (2, [e(0)]) ||| (5,[e(1),e(2)])
    XCTAssert(inner_1e0_1e12.1.isEmpty)
    XCTAssertEqual(inner_2e0_5e12.0, 0)
    
    let inner_2e10_5e2:(Double, [e]) = (2, [e(1),e(0)]) ||| (5, [e(2)])
    XCTAssert(inner_2e10_5e2.1.isEmpty)
    XCTAssertEqual(inner_2e10_5e2.0, 0)
    
    let inner_2e32_5e01:(Double, [e]) = (2, [e(3),e(2)]) ||| (5, [e(0), e(1)])
    XCTAssert(inner_2e32_5e01.1.isEmpty)
    XCTAssertEqual(inner_2e32_5e01.0, 0)
    
    let inner_2e320_5e1:(Double, [e]) = (2, [e(3),e(2),e(0)]) ||| (5, [e(1)])
    XCTAssert(inner_2e320_5e1.1.isEmpty)
    XCTAssertEqual(inner_2e320_5e1.0, 0)
    
    let inner_1e12_1e12:(Double, [e]) = (1, [e(1),e(2)]) ||| (1, [e(1), e(2)])
    XCTAssert(inner_1e12_1e12.1.isEmpty)
    XCTAssertEqual(inner_1e12_1e12.0, -1)
  }
  
  func testScalarMulGrade1() {
    
    let e4 = e(4) |*| 1234
    XCTAssertEqual(e4.0, 1234)
    XCTAssertEqual(e4.1, e(4))
    
    let e5 =  5678 |*| e(5)
    XCTAssertEqual(e5.0, 5678)
    XCTAssertEqual(e5.1, e(5))
  }
  
  func testGrade1MulGrade1WithCoefficents() {
    
    let mul_1e0_2e0:(Double, [e]) = (1, e(0)) |*| (2, e(0))
    XCTAssertEqual(mul_1e0_2e0.0, 0)
    XCTAssertEqual(mul_1e0_2e0.1.first, nil)
    
    let mul_2e1_3e1:(Double, [e]) = (2, e(1)) |*| (3, e(1))
    XCTAssertEqual(mul_2e1_3e1.0, 6)
    XCTAssertEqual(mul_2e1_3e1.1.first, nil)
    
    let mul_3e2_4e2:(Double, [e]) = (3, e(2)) |*| (-4, e(2))
    XCTAssertEqual(mul_3e2_4e2.0, -12)
    XCTAssertEqual(mul_3e2_4e2.1.first, nil)
    
    let mul_2e1_2e2:(Double, [e]) = (2, e(1)) |*| (-2, e(2))
    XCTAssertEqual(mul_2e1_2e2.0, -4)
    XCTAssertEqual(mul_2e1_2e2.1, [e(1),e(2)])
    
    let mul_2e2_2e1:(Double, [e]) = (2, e(2)) |*| (2, e(1))
    XCTAssertEqual(mul_2e2_2e1.0, -4)
    XCTAssertEqual(mul_2e2_2e1.1, [e(1),e(2)])
    
    let mul_2e2_minus2e1:(Double, [e]) = (2, e(2)) |*| (-2, e(1))
    XCTAssertEqual(mul_2e2_minus2e1.0, 4)
    XCTAssertEqual(mul_2e2_minus2e1.1, [e(1),e(2)])
  }
  
  func testGrade1MulGrade1() {
    let inner_e0:Double = e(0) ||| e(0)
    XCTAssertEqual(inner_e0, 0)
    let inner_e1:Double = e(1) ||| e(1)
    XCTAssertEqual(inner_e1, 1)
    let inner_e2:Double = e(2) ||| e(2)
    XCTAssertEqual(inner_e2, 1)
    let inner_e12:Double = e(1) ||| e(2)
    XCTAssertEqual(inner_e12, 0)
    
    let outer_e0:(Double, [e]) = e(0) |^| e(0)
    XCTAssertEqual(outer_e0.0, 0)
    XCTAssertEqual(outer_e0.1.first, nil)
    
    let outer_e1:(Double, [e]) = e(1) |^| e(1)
    XCTAssertEqual(outer_e1.0, 1)
    XCTAssertEqual(outer_e1.1.first, nil)
    
    let outer_e2:(Double, [e]) = e(2) |^| e(2)
    XCTAssertEqual(outer_e2.0, 1)
    XCTAssertEqual(outer_e2.1.first, nil)
    
    let outer_e12:(Double, [e]) = e(1) |^| e(2)
    XCTAssertEqual(outer_e12.0, 1)
    XCTAssertEqual(outer_e12.1, [e(1),e(2)])
    
    let outer_e21:(Double, [e]) = e(2) |^| e(1)
    XCTAssertEqual(outer_e21.0, -1)
    XCTAssertEqual(outer_e21.1, [e(1),e(2)])
    
    
    let mul_e0:(Double, [e]) = e(0) |*| e(0)
    XCTAssertEqual(mul_e0.0, 0)
    XCTAssertEqual(mul_e0.1.first, nil)
    
    let mul_e1:(Double, [e]) = e(1) |*| e(1)
    XCTAssertEqual(mul_e1.0, 1)
    XCTAssertEqual(mul_e1.1.first, nil)
    
    let mul_e2:(Double, [e]) = e(2) |*| e(2)
    XCTAssertEqual(mul_e2.0, 1)
    XCTAssertEqual(mul_e2.1.first, nil)
    
    let mul_e12:(Double, [e]) = e(1) |*| e(2)
    XCTAssertEqual(mul_e12.0, 1)
    XCTAssertEqual(mul_e12.1, [e(1),e(2)])
    
    let mul_e21:(Double, [e]) = e(2) |*| e(1)
    XCTAssertEqual(mul_e21.0, -1)
    XCTAssertEqual(mul_e21.1, [e(1),e(2)])
  }
  
  func testGrade2MulGrade1() {
    let outer_1e0_1e0: [(Double, [e])] = (1, e(0)) |*| (1, [e(0)])
    XCTAssert(outer_1e0_1e0.isEmpty)
    
    let outer_1e0_1e0_rhs: [(Double, [e])] = (1, [e(0)]) |*| (1, e(0))
    XCTAssert(outer_1e0_1e0_rhs.isEmpty)
    
    let outer_1e00_1e0 = (1, [e(0),e(0)]) |*| (1, e(0))
    XCTAssert(outer_1e00_1e0.isEmpty)
   
    
    let outer_1e1_1e1 = (1, [e(1)]) |*| (1, e(1))
    XCTAssert(outer_1e1_1e1.first!.1.isEmpty)
    XCTAssertEqual(outer_1e1_1e1.first!.0, 1)
    
    let outer_1e1_1e1_rev = (1, e(1)) |*| (1, [e(1)])
    XCTAssert(outer_1e1_1e1_rev.first!.1.isEmpty)
    XCTAssertEqual(outer_1e1_1e1_rev.first!.0, 1)
    
    let outer_1e01_1e1 = (1, [e(0),e(1)]) |*| (1, e(1))
    XCTAssertEqual(outer_1e01_1e1.first!.1, [e(0)])
    XCTAssertEqual(outer_1e01_1e1.first!.0, 1)
    
    let outer_1e01_1e1_rev = (1, e(1)) |*| (1, [e(0),e(1)])
    XCTAssertEqual(outer_1e01_1e1_rev.first!.1, [e(0)])
    XCTAssertEqual(outer_1e01_1e1_rev.first!.0, -1) // Sign change
    
    let outer_1e12_1e1 = (1, [e(1),e(2)]) |*| (1, e(1))
    XCTAssertEqual(outer_1e12_1e1.count, 1)
    XCTAssertEqual(outer_1e12_1e1.first!.0, -1) // Sign change
    XCTAssertEqual(outer_1e12_1e1.first!.1, [e(2)])
    
    let outer_1e12_1e1_rev = (1, e(1)) |*| (1, [e(1),e(2)])
    XCTAssertEqual(outer_1e12_1e1_rev.count, 1)
    XCTAssertEqual(outer_1e12_1e1_rev.first!.0, 1)
    XCTAssertEqual(outer_1e12_1e1_rev.first!.1, [e(2)])
    
    let outer_1e1_1e12 = (1, e(1)) |*| (1,[e(1),e(2)])
    XCTAssertEqual(outer_1e1_1e12.count, 1)
    XCTAssertEqual(outer_1e1_1e12.first!.0, 1)
    XCTAssertEqual(outer_1e1_1e12.first!.1, [e(2)])
    
    let outer_1e1_1e12_rev = (1,[e(1),e(2)]) |*| (1, e(1))
    XCTAssertEqual(outer_1e1_1e12_rev.count, 1)
    XCTAssertEqual(outer_1e1_1e12_rev.first!.0, -1) // Sign change
    XCTAssertEqual(outer_1e1_1e12_rev.first!.1, [e(2)])
    
    let outer_1e1_1e21 = (1, e(1)) |*| (1,[e(2),e(1)])
    XCTAssertEqual(outer_1e1_1e21.count, 1)
    XCTAssertEqual(outer_1e1_1e21.first!.0, -1)
    XCTAssertEqual(outer_1e1_1e21.first!.1, [e(2)])
    
    let outer_1e1_1e21_rev = (1,[e(2),e(1)]) |*| (1, e(1))
    XCTAssertEqual(outer_1e1_1e21_rev.count, 1)
    XCTAssertEqual(outer_1e1_1e21_rev.first!.0, 1)
    XCTAssertEqual(outer_1e1_1e21_rev.first!.1, [e(2)])
    
    let outer_1e0_1e12 = (1, e(0)) |*| (1,[e(1),e(2)])
    XCTAssertEqual(outer_1e1_1e21.count, 1)
    XCTAssertEqual(outer_1e0_1e12.first!.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_1e0_1e12.first!.0, 1)
    
    let outer_1e0_1e12_rev = (1,[e(1),e(2)]) |*| (1, e(0))
    XCTAssertEqual(outer_1e0_1e12_rev.count, 1)
    XCTAssertEqual(outer_1e0_1e12_rev.first!.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_1e0_1e12_rev.first!.0, 1)
    
    let outer_2e0_5e12 = (2, e(0)) |*| (5,[e(1),e(2)])
    XCTAssertEqual(outer_2e0_5e12.count, 1)
    XCTAssertEqual(outer_2e0_5e12.first!.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_2e0_5e12.first!.0, 10)
    
    let outer_2e0_5e12_rev = (5,[e(1),e(2)]) |*| (2, e(0))
    XCTAssertEqual(outer_2e0_5e12_rev.count, 1)
    XCTAssertEqual(outer_2e0_5e12_rev.first!.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_2e0_5e12_rev.first!.0, 10)
    
    let outer_2e10_5e2 = (5, e(2)) |*| (2, [e(1),e(0)])
    XCTAssertEqual(outer_2e0_5e12.count, 1)
    XCTAssertEqual(outer_2e10_5e2.first!.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_2e10_5e2.first!.0, -10)
    
    let outer_2e10_5e2_rev = (2, [e(1),e(0)]) |*| (5, e(2))
    XCTAssertEqual(outer_2e10_5e2_rev.count, 1)
    XCTAssertEqual(outer_2e10_5e2_rev.first!.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_2e10_5e2_rev.first!.0, -10)
    
    let outer_2e320_5e1 = (2, [e(3),e(2),e(0)]) |*| (5, e(1))
    XCTAssertEqual(outer_2e320_5e1.count, 1)
    XCTAssertEqual(outer_2e320_5e1.first!.1, [e(0), e(1), e(2), e(3)])
    XCTAssertEqual(outer_2e320_5e1.first!.0, -10)
    
    let outer_2e320_5e1_rev = (5, e(1)) |*| (2, [e(3),e(2),e(0)])
    XCTAssertEqual(outer_2e320_5e1_rev.count, 1)
    XCTAssertEqual(outer_2e320_5e1_rev.first!.1, [e(0), e(1), e(2), e(3)])
    XCTAssertEqual(outer_2e320_5e1_rev.first!.0, 10)
  }
  
  func testGrade2MulGrade2() {
    let outer_1e0_1e0: [(Double, [e])] = (1, [e(0)]) |*| (1, [e(0)])
    XCTAssert(outer_1e0_1e0.isEmpty)
    
    let outer_1e00_1e00 = (1, [e(0),e(0)]) |*| (1, [e(0),e(0)])
    XCTAssert(outer_1e00_1e00.isEmpty)

    
    let outer_1e1_1e1 = (1, [e(1)]) |*| (1, [e(1)])
    XCTAssert(outer_1e1_1e1.first!.1.isEmpty)
    XCTAssertEqual(outer_1e1_1e1.first!.0, 1)
    
    let outer_1e01_1e1 = (1, [e(0),e(1)]) |*| (1, [e(1)])
    XCTAssertEqual(outer_1e01_1e1.first!.1, [e(0)])
    XCTAssertEqual(outer_1e01_1e1.first!.0, 1)
    
    let outer_1e12_1e1 = (1, [e(1),e(2)]) |*| (1, [e(1)])
    XCTAssertEqual(outer_1e12_1e1.count, 1)
    XCTAssertEqual(outer_1e12_1e1.first!.0, -1)
    XCTAssertEqual(outer_1e12_1e1.first!.1, [e(2)])
    
    let outer_1e1_1e12 = (1, [e(1)]) |*| (1,[e(1),e(2)])
    XCTAssertEqual(outer_1e1_1e12.count, 1)
    XCTAssertEqual(outer_1e1_1e12.first!.0, 1)
    XCTAssertEqual(outer_1e1_1e12.first!.1, [e(2)])
    
    let outer_1e1_1e21 = (1, [e(1)]) |*| (1,[e(2),e(1)])
    XCTAssertEqual(outer_1e1_1e21.count, 1)
    XCTAssertEqual(outer_1e1_1e21.first!.0, -1)
    XCTAssertEqual(outer_1e1_1e21.first!.1, [e(2)])
    
    let outer_1e0_1e12 = (1, [e(0)]) |*| (1,[e(1),e(2)])
    XCTAssertEqual(outer_1e1_1e21.count, 1)
    XCTAssertEqual(outer_1e0_1e12.first!.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_1e0_1e12.first!.0, 1)
    
    let outer_2e0_5e12 = (2, [e(0)]) |*| (5,[e(1),e(2)])
    XCTAssertEqual(outer_2e0_5e12.count, 1)
    XCTAssertEqual(outer_2e0_5e12.first!.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_2e0_5e12.first!.0, 10)
    
    let outer_2e10_5e2 = (2, [e(1),e(0)]) |*| (5, [e(2)])
    XCTAssertEqual(outer_2e0_5e12.count, 1)
    XCTAssertEqual(outer_2e10_5e2.first!.1, [e(0), e(1), e(2)])
    XCTAssertEqual(outer_2e10_5e2.first!.0, -10)
    
    let outer_2e32_5e01 = (2, [e(3),e(2)]) |*| (5, [e(0), e(1)])
    XCTAssertEqual(outer_2e32_5e01.count, 1)
    XCTAssertEqual(outer_2e32_5e01.first!.1, [e(0), e(1), e(2), e(3)])
    XCTAssertEqual(outer_2e32_5e01.first!.0, -10)
    
    let outer_2e320_5e1 = (2, [e(3),e(2),e(0)]) |*| (5, [e(1)])
    XCTAssertEqual(outer_2e320_5e1.count, 1)
    XCTAssertEqual(outer_2e320_5e1.first!.1, [e(0), e(1), e(2), e(3)])
    XCTAssertEqual(outer_2e320_5e1.first!.0, -10)
  }
  
  func testGeometricProductTable() {
    let table:[(Double,[e])] = getTable()
    let geometricTable = tabulate(table, with: |*|).joined(separator: "\n")
    XCTAssertEqual(geometricTable, printGeometricTable())
  }
  
  func testInnerProductTable() {
    let table:[(Double,[e])] = getTable()
    let geometricTable = tabulate(table, with: |||).joined(separator: "\n")
    XCTAssertEqual(geometricTable, printInnerProductTable())
  }
  
  func testOuterProductTable() {
    let table:[(Double,[e])] = getTable()
    let geometricTable = tabulate(table, with: |^|).joined(separator: "\n")
    XCTAssertEqual(geometricTable, printOuterProductTable())
  }
  
}
