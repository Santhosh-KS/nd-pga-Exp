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
    XCTAssertEqual(outer_e0.0, 1)
    
    let outer_10e0:(Double, [e]) = (10, e(0)) |^| (10, e(0))
    XCTAssertEqual(outer_10e0.0, 100)
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
    XCTAssertEqual(outer_1e0_1e12.1, [e(0),e(1), e(2)])
    XCTAssertEqual(outer_1e0_1e12.0, 1)
    
    let outer_1e0_1e12_rev:(Double, [e]) = (1,[e(1),e(2)]) |^| (1, e(0))
    XCTAssert(!outer_1e0_1e12_rev.1.isEmpty)
    XCTAssertEqual(outer_1e0_1e12_rev.1, [e(0),e(1), e(2)])
    XCTAssertEqual(outer_1e0_1e12_rev.0, 1)
    
    let outer_2e0_5e12:(Double, [e]) = (2, e(0)) |^| (5,[e(1),e(2)])
    XCTAssert(!outer_1e0_1e12.1.isEmpty)
    XCTAssertEqual(outer_2e0_5e12.1, [e(0),e(1), e(2)])
    XCTAssertEqual(outer_2e0_5e12.0, 10)
    
    let outer_2e0_5e12_rev:(Double, [e]) = (5,[e(1),e(2)]) |^| (2, e(0))
    XCTAssert(!outer_2e0_5e12_rev.1.isEmpty)
    XCTAssertEqual(outer_2e0_5e12_rev.1, [e(0),e(1), e(2)])
    XCTAssertEqual(outer_2e0_5e12_rev.0, 10)
    
    let outer_2e10_5e2:(Double, [e]) = (2, [e(1),e(0)]) |^| (5, e(2))
    XCTAssert(!outer_2e10_5e2.1.isEmpty)
    XCTAssertEqual(outer_2e10_5e2.1, [e(0),e(1), e(2)])
    XCTAssertEqual(outer_2e10_5e2.0, -10)
    
    let outer_2e10_5e2_rev:(Double, [e]) = (5, e(2)) |^| (2, [e(1),e(0)])
    XCTAssert(!outer_2e10_5e2_rev.1.isEmpty)
    XCTAssertEqual(outer_2e10_5e2_rev.1, [e(0),e(1), e(2)])
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
    XCTAssertEqual(outer_1e0_1e12.1, [e(0),e(1), e(2)])
    XCTAssertEqual(outer_1e0_1e12.0, 1)
    
    let outer_2e0_5e12:(Double, [e]) = (2, [e(0)]) |^| (5,[e(1),e(2)])
    XCTAssert(!outer_1e0_1e12.1.isEmpty)
    XCTAssertEqual(outer_2e0_5e12.1, [e(0),e(1), e(2)])
    XCTAssertEqual(outer_2e0_5e12.0, 10)
    
    let outer_2e10_5e2:(Double, [e]) = (2, [e(1),e(0)]) |^| (5, [e(2)])
    XCTAssert(!outer_2e10_5e2.1.isEmpty)
    XCTAssertEqual(outer_2e10_5e2.1, [e(0),e(1), e(2)])
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
    XCTAssertEqual(inner_1e01_1e1.1.first!, e(0))
  
    
    let inner_1e01_1e1_rev:(Double, [e]) = (1, e(1)) ||| (1, [e(0),e(1)])
    XCTAssertEqual(inner_1e01_1e1_rev.0, -1)
    XCTAssertEqual(inner_1e01_1e1.1.first!, e(0))
    
    
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
    XCTAssertEqual(inner_1e01_1e1.1.first!, e(0))
   
    
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
    XCTAssertEqual(mul_1e0_2e0.0, 2)
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
    XCTAssertEqual(outer_e0.0, 1)
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
    XCTAssertEqual(mul_e0.0, 1)
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
    XCTAssertEqual(outer_1e01_1e1_rev.first!.0, -1)
    
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
    XCTAssertEqual(outer_2e10_5e2.first!.1, [ e(0), e(1), e(2)])
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
    XCTAssertEqual(geometricTable, printGeometricProductTable())
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
  
  func testReverseOfConstants() {
    XCTAssertEqual(|~|11, 11)
    XCTAssertEqual(|~|Float.pi, Float.pi)
  }
  
  func testReverseOfGrade1() {
    XCTAssertEqual((|~|e0).0, -1)
    XCTAssertEqual((|~|e0).1, e0.1)
    
    XCTAssertEqual((|~|e1).0, -1)
    XCTAssertEqual((|~|e1).1, e1.1)
    
    XCTAssertEqual((|~|e2).0, -1)
    XCTAssertEqual((|~|e2).1, e2.1)
    
    XCTAssertEqual((|~|e3).0, -1)
    XCTAssertEqual((|~|e3).1, e3.1)
    
    XCTAssertEqual(grade(e113), 1)
    XCTAssertEqual((|~|e113).0, 1)
    XCTAssertEqual((|~|e113).1, e113.1)
    
    XCTAssertEqual(grade(e131), 1)
    XCTAssertEqual((|~|e131).0, -1)
    XCTAssertEqual((|~|e131).1, e131.1)
    
  }
  
  func testReverseOfGrade2() {
    XCTAssertEqual((|~|e00).0, 1)
    XCTAssert((|~|e00).1.isEmpty)
    
    XCTAssertEqual((|~|e01).0, -1)
    XCTAssertEqual((|~|e01).1, e01.1)
    
    XCTAssertEqual((|~|e10).0, 1)
    XCTAssertEqual((|~|e10).1, e10.1)
    
    XCTAssertEqual((|~|e02).0, -1)
    XCTAssertEqual((|~|e02).1, e02.1)
    
    XCTAssertEqual((|~|e20).0, 1)
    XCTAssertEqual((|~|e20).1, e20.1)
    
    XCTAssertEqual((|~|e03).0, -1)
    XCTAssertEqual((|~|e03).1, e03.1)
    
    XCTAssertEqual((|~|e30).0, 1)
    XCTAssertEqual((|~|e30).1, e30.1)
    
    XCTAssertEqual((|~|e11).0, 1)
    XCTAssert((|~|e11).1.isEmpty)
    XCTAssertEqual((|~|e12).0, -1)
    XCTAssertEqual((|~|e12).1, e12.1)
    XCTAssertEqual((|~|e13).0, -1)
    XCTAssertEqual((|~|e13).1, e13.1)
    
    XCTAssertEqual((|~|e22).0, 1)
    XCTAssert((|~|e22).1.isEmpty)
    XCTAssertEqual((|~|e21).0, 1)
    XCTAssertEqual((|~|e21).1, e21.1)
    XCTAssertEqual((|~|e23).0, -1)
    XCTAssertEqual((|~|e23).1, e23.1)
  
    XCTAssertEqual((|~|e33).0, 1)
    XCTAssert((|~|e33).1.isEmpty)
    XCTAssertEqual((|~|e31).0, 1)
    XCTAssertEqual((|~|e31).1, e31.1)
    XCTAssertEqual((|~|e32).0, 1)
    XCTAssertEqual((|~|e32).1, e32.1)
  }
  
  func testReverseOfGrade3() {
    XCTAssertEqual((|~|e123).0, -1)
    XCTAssertEqual((|~|e123).1, e123.1)
    
    XCTAssertEqual((|~|e213).0, 1)
    XCTAssertEqual((|~|e213).1, e123.1)
    
    XCTAssertEqual((|~|e231).0, -1)
    XCTAssertEqual((|~|e231).1, e123.1)
    
    XCTAssertEqual((|~|e312).0, -1)
    XCTAssertEqual((|~|e312).1, e123.1)
    
    XCTAssertEqual((|~|e321).0, 1)
    XCTAssertEqual((|~|e321).1, e123.1)
  }
  
  func testInverseOfConstants() {
    let inv_e0 = e0|-||
    XCTAssertEqual(inv_e0.0, 1)
    XCTAssertEqual(inv_e0.1, e(0))
    
    let normalized_inv_e0 = normalized(inv_e0)
    XCTAssertEqual(normalized_inv_e0.0, 1)
    XCTAssertEqual(normalized_inv_e0.1, [e(0)])
    
    let inv_const_10 = 10|-||
    XCTAssertEqual(inv_const_10, 1/10)
    
    let inv_const_0 = 0|-||
    XCTAssertEqual(inv_const_0, 0)
  }
  
  func testInverseOfGrade1() {
    let inv_e1 = e1|-||
    XCTAssertEqual(inv_e1.0, 1)
    XCTAssertEqual(inv_e1.1, e(1))
    
    let normalized_inv_e1 = normalized(inv_e1)
    XCTAssertEqual(normalized_inv_e1.0, 1)
    XCTAssertEqual(normalized_inv_e1.1, [e(1)])
    
    let inv_e2 = e2|-||
    XCTAssertEqual(inv_e2.0, 1)
    XCTAssertEqual(inv_e2.1, e(2))
    
    let normalized_inv_e2 = normalized(inv_e2)
    XCTAssertEqual(normalized_inv_e2.0, 1)
    XCTAssertEqual(normalized_inv_e2.1, [e(2)])
    
    let inv_e3 = e3|-||
    XCTAssertEqual(inv_e3.0, 1)
    XCTAssertEqual(inv_e3.1, e(3))
    
    let normalized_inv_e3 = normalized(inv_e3)
    XCTAssertEqual(normalized_inv_e3.0, 1)
    XCTAssertEqual(normalized_inv_e3.1, [e(3)])
  }
  
  func testInverseOfGrade2() {
    let inv_e12 = e12|-||
    XCTAssertEqual(inv_e12.0, -1)
    XCTAssertEqual(inv_e12.1, [e(1),e(2)])
    
    let normalized_inv_e12 = normalized(inv_e12)
    XCTAssertEqual(normalized_inv_e12.0, -1)
    XCTAssertEqual(normalized_inv_e12.1, [e(1),e(2)])
    
    let inv_e21 = e21|-||
    XCTAssertEqual(inv_e21.0, 1)
    XCTAssertEqual(inv_e21.1, [e(1),e(2)])
    
    let normalized_inv_e21 = normalized(inv_e21)
    XCTAssertEqual(normalized_inv_e21.0, 1)
    XCTAssertEqual(normalized_inv_e21.1, [e(1),e(2)])
    
    let inv_e13 = e13|-||
    XCTAssertEqual(inv_e13.0, -1)
    XCTAssertEqual(inv_e13.1, [e(1),e(3)])
    
    let normalized_inv_e13 = normalized(inv_e13)
    XCTAssertEqual(normalized_inv_e13.0, -1)
    XCTAssertEqual(normalized_inv_e13.1, [e(1),e(3)])
    
    let inv_e31 = e31|-||
    XCTAssertEqual(inv_e31.0, 1)
    XCTAssertEqual(inv_e31.1, [e(1),e(3)])
    
    let normalized_inv_e31 = normalized(inv_e31)
    XCTAssertEqual(normalized_inv_e31.0, 1)
    XCTAssertEqual(normalized_inv_e31.1, [e(1),e(3)])
    
    let inv_e23 = e23|-||
    XCTAssertEqual(inv_e23.0, -1)
    XCTAssertEqual(inv_e23.1, [e(2),e(3)])
    
    let normalized_inv_e23 = normalized(inv_e23)
    XCTAssertEqual(normalized_inv_e23.0, -1)
    XCTAssertEqual(normalized_inv_e23.1, [e(2),e(3)])
    
    let inv_e32 = e32|-||
    XCTAssertEqual(inv_e32.0, 1)
    XCTAssertEqual(inv_e32.1, [e(2),e(3)])
    
    let normalized_inv_e32 = normalized(inv_e32)
    XCTAssertEqual(normalized_inv_e32.0, 1)
    XCTAssertEqual(normalized_inv_e32.1, [e(2),e(3)])
  }
  
  func testInverseOfGrade3() {
    let inv_e123 = e123|-||
    XCTAssertEqual(inv_e123.0, -1)
    XCTAssertEqual(inv_e123.1, [e(1),e(2), e(3)])
    
    let normalized_inv_e123 = normalized(inv_e123)
    XCTAssertEqual(normalized_inv_e123.0, -1)
    XCTAssertEqual(normalized_inv_e123.1, [e(1),e(2), e(3)])
    
    let inv_e213 = e213|-||
    XCTAssertEqual(inv_e213.0, 1)
    XCTAssertEqual(inv_e213.1, [e(1),e(2), e(3)])
    
    let normalized_inv_e213 = normalized(inv_e213)
    XCTAssertEqual(normalized_inv_e213.0, 1)
    XCTAssertEqual(normalized_inv_e213.1, [e(1),e(2), e(3)])
    
    let inv_e132 = e132|-||
    XCTAssertEqual(inv_e132.0, 1)
    XCTAssertEqual(inv_e132.1, [e(1),e(2), e(3)])
    
    let normalized_inv_e132 = normalized(inv_e132)
    XCTAssertEqual(normalized_inv_e132.0, 1)
    XCTAssertEqual(normalized_inv_e132.1, [e(1),e(2), e(3)])
    
    let inv_e312 = e312|-||
    XCTAssertEqual(inv_e312.0, -1)
    XCTAssertEqual(inv_e312.1, [e(1),e(2), e(3)])
    
    let normalized_inv_e312 = normalized(inv_e312)
    XCTAssertEqual(normalized_inv_e312.0, -1)
    XCTAssertEqual(normalized_inv_e312.1, [e(1),e(2), e(3)])
    
    let inv_e231 = e231|-||
    XCTAssertEqual(inv_e231.0, -1)
    XCTAssertEqual(inv_e231.1, [e(1),e(2), e(3)])
    
    let normalized_inv_e231 = normalized(inv_e231)
    XCTAssertEqual(normalized_inv_e231.0, -1)
    XCTAssertEqual(normalized_inv_e231.1, [e(1),e(2), e(3)])
    
    let inv_e321 = e321|-||
    XCTAssertEqual(inv_e321.0, 1)
    XCTAssertEqual(inv_e321.1, [e(1),e(2), e(3)])
    
    let normalized_inv_e321 = normalized(inv_e321)
    XCTAssertEqual(normalized_inv_e321.0, 1)
    XCTAssertEqual(normalized_inv_e321.1, [e(1),e(2), e(3)])
  }
  
  func testInverseProperty() {
    // A |*| A|-|| = 1
    // i.e A * Inverse(A) = 1
    let ten:Double = 10
    let ten_inv = Inverse(of: ten)
    XCTAssertEqual(ten |*| ten_inv, 1)
    
    let pi = Float.pi
    let pi_inv = Inverse(of: pi)
    XCTAssertEqual(pi |*| pi_inv, 1)
    
    let e0_inv = Inverse(of: e0)
    XCTAssertEqual((e0 |*| e0_inv).0, 1)
    XCTAssertEqual((e0 |*| e0_inv).1, [])
    
    let e1_inv = Inverse(of: e1)
    XCTAssertEqual((e1 |*| e1_inv).0, 1)
    XCTAssertEqual((e1 |*| e1_inv).1, [])
    let e2_inv = Inverse(of: e2)
    XCTAssertEqual((e2 |*| e2_inv).0, 1)
    XCTAssertEqual((e2 |*| e2_inv).1, [])
    let e3_inv = Inverse(of: e3)
    XCTAssertEqual((e3 |*| e3_inv).0, 1)
    XCTAssertEqual((e3 |*| e3_inv).1, [])
    
    let e12_inv = Inverse(of: e12)
    XCTAssertEqual((e12 |*| e12_inv).first!.0, 1)
    XCTAssertEqual((e12 |*| e12_inv).first!.1, [])
    let e21_inv = e21|-||
    XCTAssertEqual((e21 |*| e21_inv).first!.0, 1)
    XCTAssertEqual((e21 |*| e21_inv).first!.1, [])
    let e13_inv = e13|-||
    XCTAssertEqual((e13 |*| e13_inv).first!.0, 1)
    XCTAssertEqual((e13 |*| e13_inv).first!.1, [])
    let e31_inv = Inverse(of: e31)
    XCTAssertEqual((e31 |*| e31_inv).first!.0, 1)
    XCTAssertEqual((e31 |*| e31_inv).first!.1, [])
    let e23_inv = Inverse(of: e23)
    XCTAssertEqual((e23 |*| e23_inv).first!.0, 1)
    XCTAssertEqual((e23 |*| e23_inv).first!.1, [])
    let e32_inv = e32|-||
    XCTAssertEqual((e32 |*| e32_inv).first!.0, 1)
    XCTAssertEqual((e32 |*| e32_inv).first!.1, [])
    
    let e123_inv = Inverse(of: e123)
    XCTAssertEqual((e123 |*| e123_inv).first!.0, 1)
    XCTAssertEqual((e123 |*| e123_inv).first!.1, [])
    let e213_inv = e213|-||
    XCTAssertEqual((e213 |*| e213_inv).first!.0, 1)
    XCTAssertEqual((e213 |*| e213_inv).first!.1, [])
    let e132_inv = e132|-||
    XCTAssertEqual((e132 |*| e132_inv).first!.0, 1)
    XCTAssertEqual((e132 |*| e132_inv).first!.1, [])
    let e312_inv = Inverse(of: e312)
    XCTAssertEqual((e312 |*| e312_inv).first!.0, 1)
    XCTAssertEqual((e312 |*| e312_inv).first!.1, [])
    let e231_inv = Inverse(of: e231)
    XCTAssertEqual((e231 |*| e231_inv).first!.0, 1)
    XCTAssertEqual((e231 |*| e231_inv).first!.1, [])
    let e321_inv = e321|-||
    XCTAssertEqual((e321 |*| e321_inv).first!.0, 1)
    XCTAssertEqual((e321 |*| e321_inv).first!.1, [])
  
  }
  
  func testInversePropertyOnEpsilonsWithCoefficients() {
    let e1_inv = Inverse(of: (2.0 |*| e1))
    XCTAssertEqual((e1 |*| e1_inv).0, 1/2)
    XCTAssertEqual((e1 |*| e1_inv).1, [])
  }
  
  func testDualOfGrade0() {
    XCTAssertEqual(dual(e0).0, 1)
    XCTAssertEqual(dual(e0).1, e0123.1)
    XCTAssertEqual(dual(e11).0, 1)
    XCTAssertEqual(dual(e11).1, e123.1)
    XCTAssertEqual(dual(e22).0, 1)
    XCTAssertEqual(dual(e22).1, e123.1)
    XCTAssertEqual(dual(e33).0, 1)
    XCTAssertEqual(dual(e33).1, e123.1)
    
    XCTAssertEqual(dual(10).0, 10)
    XCTAssertEqual(dual(10).1, e0123.1)
  }
  
  func testOperatorDualOfGrade0() {
    XCTAssertEqual((|!|e0).0, 1)
    XCTAssertEqual((|!|e0).1, e0123.1)
    XCTAssertEqual((|!|e0).0, 1)
    XCTAssertEqual((|!|e0).1, e0123.1)
    XCTAssertEqual((|!|e0).0, 1)
    XCTAssertEqual((|!|e0).1, e0123.1)
    XCTAssertEqual((|!|e0).0, 1)
    XCTAssertEqual((|!|e0).1, e0123.1)
    
    XCTAssertEqual((|!|10).0, 10)
    XCTAssertEqual((|!|10).1, e0123.1)
  }
  
  func testDualOfGrade1() {
    XCTAssertEqual(dual(e1).0, 1)
    XCTAssertEqual(dual(e1).1, e23.1)
    XCTAssertEqual(dual(e2).0, -1)
    XCTAssertEqual(dual(e2).1, e13.1)
    XCTAssertEqual(dual(e3).0, 1)
    XCTAssertEqual(dual(e3).1, e12.1)
  }
  
  func testOperatorDualOfGrade1() {
    XCTAssertEqual((|!|e1).0, 1)
    XCTAssertEqual((|!|e1).1, e23.1)
    XCTAssertEqual((|!|e2).0, -1)
    XCTAssertEqual((|!|e2).1, e13.1)
    XCTAssertEqual((|!|e3).0, 1)
    XCTAssertEqual((|!|e3).1, e12.1)
  }
  
  func testDualOfGrade2() {
    XCTAssertEqual(dual(e12).0, -1)
    XCTAssertEqual(dual(e12).1.first!, e3.1)
    XCTAssertEqual(dual(e21).0, 1)
    XCTAssertEqual(dual(e21).1.first!, e3.1)
    XCTAssertEqual(dual(e13).0, 1)
    XCTAssertEqual(dual(e13).1.first!, e2.1)
    XCTAssertEqual(dual(e31).0, -1)
    XCTAssertEqual(dual(e31).1.first!, e2.1)
    XCTAssertEqual(dual(e23).0, -1)
    XCTAssertEqual(dual(e23).1.first!, e1.1)
    XCTAssertEqual(dual(e32).0, 1)
    XCTAssertEqual(dual(e32).1.first!, e1.1)
  }
  
  func testDualOfGrade3() {
    XCTAssertEqual(dual(e123).0, -1)
    XCTAssertEqual(dual(e123).1, [])
    XCTAssertEqual(dual(e213).0, 1)
    XCTAssertEqual(dual(e213).1, [])
    XCTAssertEqual(dual(e132).0, 1)
    XCTAssertEqual(dual(e132).1, [])
    XCTAssertEqual(dual(e312).0, -1)
    XCTAssertEqual(dual(e312).1, [])
    XCTAssertEqual(dual(e231).0, -1)
    XCTAssertEqual(dual(e231).1, [])
    XCTAssertEqual(dual(e321).0, 1)
    XCTAssertEqual(dual(e321).1, [])
  }
  
  func testConjugateOfGrade0() {
    XCTAssertEqual(conjugate(e0).0, 1)
    let c_10:Double = conjugate(10.0)
    XCTAssertEqual(c_10, 10)
    XCTAssertEqual(conjugate(e11).0, 1)
    XCTAssertEqual(conjugate(e22).0, 1)
    XCTAssertEqual(conjugate(e33).0, 1)
    XCTAssertEqual(conjugate(e11).1, [])
    XCTAssertEqual(conjugate(e22).1, [])
    XCTAssertEqual(conjugate(e33).1, [])
    
    XCTAssertEqual(conjugate((10 |*| e11)).0, 10)
    XCTAssertEqual(conjugate((1.1 |*| e22)).0, 1.1)
    XCTAssertEqual(conjugate((3.14 |*| e33)).0, 3.14)
  }
  // TODO: Fix Conjugate issues
  /*
  func testConjugateOfMultigrade() {
    let A = (1 |*| e0) |+| (2|*|e1) |+| (3|*|e12) |+| (4 |*| e123)
    let A_conj = conjugate(A)
    let expectedResult:[(Double, [e])] = [(1,[]),
                                          (-2,[e(1)]),
                                          (-3,[e(1), e(2)]),
                                          (-4,[e(1),e(2),e(3)])]
    
    for (a_conj, e_res) in zip2(A_conj, expectedResult) {
      XCTAssertEqual(a_conj.0, e_res.0)
      XCTAssertEqual(a_conj.1, e_res.1)
    }
    
    let A_gp_A_conj = A |*| A_conj
    let A_gp_A_conj_expected_result = [(22.0, []),
                                       (24.0, [e(3)]),
                                       (-16.0, [e(2), e(3)])]
    for (a_gp_a_conj, e_res) in zip2(A_gp_A_conj, A_gp_A_conj_expected_result) {
      XCTAssertEqual(a_gp_a_conj.0, e_res.0)
      XCTAssertEqual(a_gp_a_conj.1, e_res.1)
    }
  }
  */
  func testRegressiveProductOfScalars() {
    let rp_10 = 10 |&*| 10
    XCTAssertEqual(rp_10.0, 0)
    XCTAssertEqual(rp_10.1, [])
    
//    XCTAssertEqual(rp_10.0, 1)
//    XCTAssertEqual(rp_10.1, [e(1),e(2),e(3)])
    
    let rp_e0 = e0 |&*| e0
    XCTAssertEqual(rp_e0.0, 0)
    XCTAssertEqual(rp_e0.1, [])
    
//    XCTAssertEqual(rp_e0.0, 1)
//    XCTAssertEqual(rp_e0.1, [e(1),e(2),e(3)])
    
    let rp_pi = Float.pi |&*| Float.pi
    XCTAssertEqual(rp_pi.0, 0)
    XCTAssertEqual(rp_pi.1, [])
    
//    XCTAssertEqual(rp_pi.0, 1)
//    XCTAssertEqual(rp_pi.1, [e(1),e(2),e(3)])
    
    let rp_e1 = e1 |&*| e1
    XCTAssertEqual(rp_e1.0, 0)
    XCTAssertEqual(rp_e1.1, [])
    
//    XCTAssertEqual(rp_e1.0, 1)
//    XCTAssertEqual(rp_e1.1, [e(1), e(2),e(3)])
    
    let rp_e2 = e2 |&*| e2
    XCTAssertEqual(rp_e2.0, 0)
    XCTAssertEqual(rp_e2.1, [])
    
//    XCTAssertEqual(rp_e2.0, 1)
//    XCTAssertEqual(rp_e2.1, [e(1), e(2),e(3)])
    
    let rp_e3 = e3 |&*| e3
    XCTAssertEqual(rp_e3.0, 0)
    XCTAssertEqual(rp_e3.1, [])
    
//    XCTAssertEqual(rp_e3.0, 1)
//    XCTAssertEqual(rp_e3.1, [e(1), e(2),e(3)])
  }
  
  // TODO: Add more tests for RegressiveProduct of grade2.. etc.
  func testRegressiveProductOfGrade1() {
    let rp_e1_e2 = e1 |&*| e2
    XCTAssertEqual(rp_e1_e2.0, 0)
    XCTAssertEqual(rp_e1_e2.1, [])
  }
  
 
}
