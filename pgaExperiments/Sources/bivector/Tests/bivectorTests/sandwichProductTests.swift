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
    
    let const10_sp_e1_0:(Double, e) = 10 |<*>| e(1)
    let const10_sp_e1_0_manual:(Double, e) = (10 |*| e(1) |*| |~|10)
    XCTAssertEqual(const10_sp_e1_0.0,  const10_sp_e1_0_manual.0)
    XCTAssertEqual(const10_sp_e1_0.1,  const10_sp_e1_0_manual.1)
    
    let e2_sp_e2_0:(Double, [e]) = e(2) |<*>| e(2)
    let e2_sp_e2_0_manual:(Double, [e]) = (e(2) |*| e(2) |*| |~|e(2)).first!
    XCTAssertEqual(e2_sp_e2_0.0,  e2_sp_e2_0_manual.0)
    XCTAssertEqual(e2_sp_e2_0.1,  e2_sp_e2_0_manual.1)
    
    let e2_sp_10_0:(Double, [e]) = e(2) |<*>| 10
    let e2_sp_10_0_manual:(Double, [e]) = (e(2) |*| 10 |*| |~|e(2))
    XCTAssertEqual(e2_sp_10_0.0,  e2_sp_10_0_manual.0)
    XCTAssertEqual(e2_sp_10_0.1,  e2_sp_10_0_manual.1)
    
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
    
    let e21_sp_e12 = (e21 |<*>| e12).first!
    let e21_sp_e12_manual = (e21 |*| e12 |*| [|~|e21]).first!
    XCTAssertEqual(e21_sp_e12.0,  e21_sp_e12_manual.0)
    XCTAssertEqual(e21_sp_e12.1,  e21_sp_e12_manual.1)

    let e23_sp_e32 = (e23 |<*>| e32).first!
    let e23_sp_e32_manual = (e23 |*| e32 |*| [|~|e23]).first!
    XCTAssertEqual(e23_sp_e32.0,  e23_sp_e32_manual.0)
    XCTAssertEqual(e23_sp_e32.1,  e23_sp_e32_manual.1)
    
    let e32_sp_e23 = (e32 |<*>| e23).first!
    let e32_sp_e23_manual = (e32 |*| e23 |*| [|~|e32]).first!
    XCTAssertEqual(e32_sp_e23.0,  e32_sp_e23_manual.0)
    XCTAssertEqual(e32_sp_e23.1,  e32_sp_e23_manual.1)

    let e13_sp_e31 = (e13 |<*>| e31).first!
    let e13_sp_e31_manual = (e13 |*| e31 |*| [|~|e13]).first!
    XCTAssertEqual(e13_sp_e31.0,  e13_sp_e31_manual.0)
    XCTAssertEqual(e13_sp_e31.1,  e13_sp_e31_manual.1)
    
    let e31_sp_e13 = (e31 |<*>| e13).first!
    let e31_sp_e13_manual = (e31 |*| e13 |*| [|~|e31]).first!
    XCTAssertEqual(e31_sp_e13.0,  e31_sp_e13_manual.0)
    XCTAssertEqual(e31_sp_e13.1,  e31_sp_e13_manual.1)
  }
  
  func testSandwichProductOfGrade3() {
    
    let e111_sp_e111 = (e111 |<*>| e111).first!
    let e111_sp_e111_manual = (e111 |*| e111 |*| [|~|e111]).first!
    XCTAssertEqual(e111_sp_e111.0,  e111_sp_e111_manual.0)
    XCTAssertEqual(e111_sp_e111.1,  e111_sp_e111_manual.1)
    
    let e222_sp_e222 = (e222 |<*>| e222).first!
    let e222_sp_e222_manual = (e222 |*| e222 |*| [|~|e222]).first!
    XCTAssertEqual(e222_sp_e222.0,  e222_sp_e222_manual.0)
    XCTAssertEqual(e222_sp_e222.1,  e222_sp_e222_manual.1)
    
    let e333_sp_e333 = (e333 |<*>| e333).first!
    let e333_sp_e333_manual = (e333 |*| e333 |*| [|~|e333]).first!
    XCTAssertEqual(e333_sp_e333.0,  e333_sp_e333_manual.0)
    XCTAssertEqual(e333_sp_e333.1,  e333_sp_e333_manual.1)
    
    let e123_sp_e213 = (e123 |<*>| e213).first!
    let e123_sp_e213_manual = (e123 |*| e213 |*| [|~|e123]).first!
    XCTAssertEqual(e123_sp_e213.0,  e123_sp_e213_manual.0)
    XCTAssertEqual(e123_sp_e213.1,  e123_sp_e213_manual.1)
    
    let e213_sp_e123 = (e213 |<*>| e123).first!
    let e213_sp_e123_manual = (e213 |*| e123 |*| [|~|e213]).first!
    XCTAssertEqual(e213_sp_e123.0,  e213_sp_e123_manual.0)
    XCTAssertEqual(e213_sp_e123.1,  e213_sp_e123_manual.1)
    
    let e231_sp_e321 = (e231 |<*>| e321).first!
    let e231_sp_e321_manual = (e231 |*| e321 |*| [|~|e231]).first!
    XCTAssertEqual(e231_sp_e321.0,  e231_sp_e321_manual.0)
    XCTAssertEqual(e231_sp_e321.1,  e231_sp_e321_manual.1)
    
    let e321_sp_e231 = (e321 |<*>| e231).first!
    let e321_sp_e231_manual = (e321 |*| e231 |*| [|~|e321]).first!
    XCTAssertEqual(e321_sp_e231.0,  e321_sp_e231_manual.0)
    XCTAssertEqual(e321_sp_e231.1,  e321_sp_e231_manual.1)
    
    let e132_sp_e312 = (e132 |<*>| e312).first!
    let e132_sp_e312_manual = (e132 |*| e312 |*| [|~|e132]).first!
    XCTAssertEqual(e132_sp_e312.0,  e132_sp_e312_manual.0)
    XCTAssertEqual(e132_sp_e312.1,  e132_sp_e312_manual.1)
    
    let e312_sp_e132 = (e312 |<*>| e132).first!
    let e312_sp_e132_manual = (e312 |*| e132 |*| [|~|e312]).first!
    XCTAssertEqual(e312_sp_e132.0,  e312_sp_e132_manual.0)
    XCTAssertEqual(e312_sp_e132.1,  e312_sp_e132_manual.1)
  }
}
