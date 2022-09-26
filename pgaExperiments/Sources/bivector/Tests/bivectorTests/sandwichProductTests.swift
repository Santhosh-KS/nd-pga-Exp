import XCTest

final class sandwichProductTests: XCTestCase {
  
  func testSandwichProductOfScalars() {
    XCTAssertEqual(10 |<*>| 10, 10 * 10 * 10)
    XCTAssertEqual(Float.pi |<*>| Float.pi, pow(Float.pi, 3))
  }
  
  func testSandwichProductOfArrayScalars() {
    XCTAssertEqual([10.0] |<*>| [10.0], 10 * 10 * 10)
    XCTAssertEqual([Float.pi] |<*>| [Float.pi], pow(Float.pi, 3))
    
    let a = [2.0, 3.0]
    XCTAssertEqual( a |<*>| a,  pow(a.reduce(1, *), 3.0) )
    
    let b = [Float.pi, 0.5*Float.pi]
    XCTAssertEqual( b |<*>| b, pow(b.reduce(1, *), 3), accuracy:0.001)
    
    let c = [2.0, 3.0, 4.0]
    let d = [5.0, 6.0]
    XCTAssertEqual( c |<*>| d, (c + d + c).reduce(1, *))
  }
  
  func testSandwichProductOfGrade1() {
    let e1_sp_e1_0:(Double, [e]) = e(1) |<*>| e(1)
    let e1_sp_e1_0_manual:(Double, [e]) = (e(1) |*| e(1) |*| |~|e(1)).first!
    XCTAssertEqual(e1_sp_e1_0.0,  e1_sp_e1_0_manual.0)
    XCTAssertEqual(e1_sp_e1_0.1,  e1_sp_e1_0_manual.1)
    
    let e2_sp_e2_0:(Double, [e]) = e(2) |<*>| e(2)
    let e2_sp_e2_0_manual:(Double, [e]) = (e(2) |*| e(2) |*| |~|e(2)).first!
    XCTAssertEqual(e2_sp_e2_0.0,  e2_sp_e2_0_manual.0)
    XCTAssertEqual(e2_sp_e2_0.1,  e2_sp_e2_0_manual.1)
    
    let e3_sp_e3_0:(Double, [e]) = e(3) |<*>| e(3)
    let e3_sp_e3_0_manual:(Double, [e]) = (e(3) |*| e(3) |*| |~|e(3)).first!
    XCTAssertEqual(e3_sp_e3_0.0,  e3_sp_e3_0_manual.0)
    XCTAssertEqual(e3_sp_e3_0.1,  e3_sp_e3_0_manual.1)
    
    let e1_sp_e1 = e1 |<*>| e1
    let e1_sp_e1_manual = (e1 |*| e1 |*| |~|e1).first!
    XCTAssertEqual(e1_sp_e1.0,  e1_sp_e1_manual.0)
    XCTAssertEqual(e1_sp_e1.1,  e1_sp_e1_manual.1)
    
    let e2_sp_e2 = e2 |<*>| e2
    let e2_sp_e2_manual = (e2 |*| e2 |*| |~|e2).first!
    XCTAssertEqual(e2_sp_e2.0,  e2_sp_e2_manual.0)
    XCTAssertEqual(e2_sp_e2.1,  e2_sp_e2_manual.1)
    
    let e3_sp_e3 = e3 |<*>| e3
    let e3_sp_e3_manual = (e3 |*| e3 |*| |~|e3).first!
    XCTAssertEqual(e3_sp_e3.0,  e3_sp_e3_manual.0)
    XCTAssertEqual(e3_sp_e3.1,  e3_sp_e3_manual.1)
    
    let e1_sp_e2 = e1 |<*>| e2
    let e1_sp_e2_manual = (e1 |*| e2 |*| |~|e1).first!
    XCTAssertEqual(e1_sp_e2.0,  e1_sp_e2_manual.0)
    XCTAssertEqual(e1_sp_e2.1,  e1_sp_e2_manual.1)
    
    let e2_sp_e1 = e2 |<*>| e1
    let e2_sp_e1_manual = (e2 |*| e1 |*| |~|e2).first!
    XCTAssertEqual(e2_sp_e1.0,  e2_sp_e1_manual.0)
    XCTAssertEqual(e2_sp_e1.1,  e2_sp_e1_manual.1)
    
    let e2_sp_e3 = e2 |<*>| e3
    let e2_sp_e3_manual = (e2 |*| e3 |*| |~|e2).first!
    XCTAssertEqual(e2_sp_e3.0,  e2_sp_e3_manual.0)
    XCTAssertEqual(e2_sp_e3.1,  e2_sp_e3_manual.1)
    
    let e3_sp_e2 = e3 |<*>| e2
    let e3_sp_e2_manual = (e3 |*| e2 |*| |~|e3).first!
    XCTAssertEqual(e3_sp_e2.0,  e3_sp_e2_manual.0)
    XCTAssertEqual(e3_sp_e2.1,  e3_sp_e2_manual.1)
    
    let e1_sp_e3 = e1 |<*>| e3
    let e1_sp_e3_manual = (e1 |*| e3 |*| |~|e1).first!
    XCTAssertEqual(e1_sp_e3.0,  e1_sp_e3_manual.0)
    XCTAssertEqual(e1_sp_e3.1,  e1_sp_e3_manual.1)
    
    let e3_sp_e1 = e3 |<*>| e1
    let e3_sp_e1_manual = (e3 |*| e1 |*| |~|e3).first!
    XCTAssertEqual(e3_sp_e1.0,  e3_sp_e1_manual.0)
    XCTAssertEqual(e3_sp_e1.1,  e3_sp_e1_manual.1)
  }
  
  func testSandwichProductOfGrade2() {
    let e1s_sp_e1s_0:(Double, [e]) = ([e(1)] |<*>| [e(1)]).first!
    let e1s_sp_e1s_0_manual:(Double, [e]) = ([e(1)] |*| [e(1)] |*| [|~|[e(1)]]).first!
    XCTAssertEqual(e1s_sp_e1s_0.0,  e1s_sp_e1s_0_manual.0)
    XCTAssertEqual(e1s_sp_e1s_0.1,  e1s_sp_e1s_0_manual.1)
    
    let e2s_sp_e2s_0:(Double, [e]) = ([e(2)] |<*>| [e(2)]).first!
    let e2s_sp_e2s_0_manual:(Double, [e]) = ([e(2)] |*| [e(2)] |*| [|~|[e(2)]]).first!
    XCTAssertEqual(e2s_sp_e2s_0.0,  e2s_sp_e2s_0_manual.0)
    XCTAssertEqual(e2s_sp_e2s_0.1,  e2s_sp_e2s_0_manual.1)
    
    let e3s_sp_e3s_0:(Double, [e]) = ([e(3)] |<*>| [e(3)]).first!
    let e3s_sp_e3s_0_manual:(Double, [e]) = ([e(3)] |*| [e(3)] |*| [|~|[e(3)]]).first!
    XCTAssertEqual(e3s_sp_e3s_0.0,  e3s_sp_e3s_0_manual.0)
    XCTAssertEqual(e3s_sp_e3s_0.1,  e3s_sp_e3s_0_manual.1)
    
    let e11_sp_e11 = (e11 |<*>| e11).first!
    let e11_sp_e11_manual = (e11 |*| e11 |*| [|~|e11]).first!
    XCTAssertEqual(e11_sp_e11.0,  e11_sp_e11_manual.0)
    XCTAssertEqual(e11_sp_e11.1,  e11_sp_e11_manual.1)
    
    let e22_sp_e22 = (e22 |<*>| e22).first!
    let e22_sp_e22_manual = (e22 |*| e22 |*| [|~|e22]).first!
    XCTAssertEqual(e22_sp_e22.0,  e22_sp_e22_manual.0)
    XCTAssertEqual(e22_sp_e22.1,  e22_sp_e22_manual.1)
    
    let e33_sp_e33 = (e33 |<*>| e33).first!
    let e33_sp_e33_manual = (e33 |*| e33 |*| [|~|e33]).first!
    XCTAssertEqual(e33_sp_e33.0,  e33_sp_e33_manual.0)
    XCTAssertEqual(e33_sp_e33.1,  e33_sp_e33_manual.1)
    
    let e12_sp_e21 = (e12 |<*>| e21).first!
    let e12_sp_e21_manual = (e12 |*| e21 |*| [|~|e12]).first!
    XCTAssertEqual(e12_sp_e21.0,  e12_sp_e21_manual.0)
    XCTAssertEqual(e12_sp_e21.1,  e12_sp_e21_manual.1)
    
//    let e2_sp_e1 = e2 |<*>| e1
//    let e2_sp_e1_manual = (e2 |*| e1 |*| |~|e2).first!
//    XCTAssertEqual(e2_sp_e1.0,  e2_sp_e1_manual.0)
//    XCTAssertEqual(e2_sp_e1.1,  e2_sp_e1_manual.1)
//    
//    let e2_sp_e3 = e2 |<*>| e3
//    let e2_sp_e3_manual = (e2 |*| e3 |*| |~|e2).first!
//    XCTAssertEqual(e2_sp_e3.0,  e2_sp_e3_manual.0)
//    XCTAssertEqual(e2_sp_e3.1,  e2_sp_e3_manual.1)
//    
//    let e3_sp_e2 = e3 |<*>| e2
//    let e3_sp_e2_manual = (e3 |*| e2 |*| |~|e3).first!
//    XCTAssertEqual(e3_sp_e2.0,  e3_sp_e2_manual.0)
//    XCTAssertEqual(e3_sp_e2.1,  e3_sp_e2_manual.1)
//    
//    let e1_sp_e3 = e1 |<*>| e3
//    let e1_sp_e3_manual = (e1 |*| e3 |*| |~|e1).first!
//    XCTAssertEqual(e1_sp_e3.0,  e1_sp_e3_manual.0)
//    XCTAssertEqual(e1_sp_e3.1,  e1_sp_e3_manual.1)
//    
//    let e3_sp_e1 = e3 |<*>| e1
//    let e3_sp_e1_manual = (e3 |*| e1 |*| |~|e3).first!
//    XCTAssertEqual(e3_sp_e1.0,  e3_sp_e1_manual.0)
//    XCTAssertEqual(e3_sp_e1.1,  e3_sp_e1_manual.1)
  }
}
