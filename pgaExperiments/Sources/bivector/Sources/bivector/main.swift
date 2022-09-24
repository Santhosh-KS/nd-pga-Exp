//print("e0",e0)
//print("e1",e1)
//print("e2",e2)
//print("e3",e3)
//print("e00",e00)
//print("e01",e01)
//print("e02",e02)
//print("e03",e03)
//print("e10",e10)
//print("e11",e11)
//print("e12",e12)
//print("e13",e13)
//print("e20",e20)
//print("e21",e21)
//print("e22",e22)
//print("e23",e23)
//print("e30",e30)
//print("e31",e31)
//print("e32",e32)
//print("e33",e33)
//print("e000", e000)
//print("e001", e001)
//print("e002", e002)
//print("e003", e003)
////print("e010", e010)
//print("e011", e011)
//print("e012", e012)
//print("e013", e013)
////print("e020", e020)
//print("e021", e021)
//print("e022", e022)
//print("e023", e023)
////print("e030", e030)
//print("e031", e031)
//print("e032", e032)
//print("e033", e033)
//
//
//print(printGeometricTable())
////print(printInnerProductTable())
////print(printOuterProductTable())
//
////let tmp:(Double,[e]) = e012
////print(|~|e321)
////
////print(grade(e112))
////let b = (e00 |*| e0)
////print(b)
////
////let inv1 = e12|-||
////print(inv1)
////
////print(|~|e123)
//
//// (ae12 + be23)(ae21 + be32)
//let ae12 = 10 |*| e12
//let be23 =  3 |*| e23
//let ae21 = 10 |*| e12
//let be32 =  3 |*| e32
//
//let ae12_plus_be23 = ae12 |+| be23
//let ae21_plus_be32 = ae21 |+| be32
//
//print("ae12_plus_be23 = ", ae12_plus_be23)
//print("ae21_plus_be32 = ", ae21_plus_be32)
//
//let resultGp = (ae12 |+| be23) |*| (ae21 |+| be32)
//print("resultGp = ", resultGp)
//let resultOp = (ae12 |+| be23) |^| (ae21 |+| be32)
//print("resultOp = ", resultOp)
//let resultIp = (ae12 |+| be23) ||| (ae21 |+| be32)
//print("resultIp = ", resultIp)
//
//print(grade(with: 0, in: resultGp))
//print(grade(with: 1, in: resultGp))
//print(grade(with: 2, in: resultGp))
//print(grade(with: 3, in: resultGp))
//
////print("resultIp|-|| = ", resultIp|-||)
//
////A = 1 + 2*e1 + 3*e12 + 4*e123
////var A = (1 |*| e0) |+| (2|*|e1) |+| (3|*|e12) |+| (4|*|e123)
////let A = (1.0 |*| [e(0)])
////print(A)
////e12
//
//print(|~|e12)

//let p = reduce(with: |+|, A |*| A_inv |> compactMap)
//print(p)
//1 + (2^e1) + (3^e12) + (4^e123)
// e0 + 2e1 + 3e12 + 4e123
// (e0 + 2e1 + 3e12 + 4e123) * (e0 + 2e1 + 3e12 + 4e123)
// e0*e0 + 2e1*e0 + 3e12 * e0 + 4e123 * e0
// e0*2e1 + 2e1*2e1 + 3e12*2e1 + 4e123 * 2e1
// e0*3e12 + 2e1*3e12 + 3e12*3e12 + 4e123*3e12
// e0*4e123 + 2e1*4e123 + 3e12*4e123 + 4e123*4e123

//(0.03333333333333333, []),
//(0.06666666666666667, [e(1)]),
//(-0.1, [e(1), e(2)]),
//(-0.13333333333333333, [e(1), e(2), e(3)])
//let a = 2 |*| e1
//print(a)
//
//let a_inv = a|-||
//print(a_inv)
//
//let id_a = a |*| a_inv
//print(id_a)
//
//let b = 3 |*| e12
//print(b)
//
//let b_inv = b|-||
//print(b_inv)
//
//let id_b = b |*| b_inv
//print(id_b)
//
//let c = 4 |*| e123
//print(c)
//
//let c_inv = c|-||
//print(c_inv)
//
//let id_c = c |*| c_inv
//print(id_c)

// [(Double, e)] |+| (Double, [e])
// [(A,[e])], (A, [e])
//e123
var A = (1 ||| e0) |+| (2|||e1) |+| (3|||e12) |+| (4 ||| e123)

//print("%%%%%%%%%%%%%%%%")
//print("Input A = ", A)
//print("Conjugate A = ", conjugate(A))
//print(" A * A_conj = ", A |*| conjugate(A))
print("A Inverse = ", A|-||)
print("Id = ", A |*| (A|-||))
