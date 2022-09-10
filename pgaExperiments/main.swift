let e0 = (1.0 |*| e(0)).first!
let e1 = (1.0 |*| e(1)).first!
let e2 = (1.0 |*| e(2)).first!
let e3 = (1.0 |*| e(3)).first!
let e4 = (1.0 |*| e(4)).first!

print("e0 =",e0)
print("e1 =",e1)
print("e2 =",e2)
print("e3 =",e3)
print("e4 =",e4)

let r0 = (e(0) |*| 1.0).first!
let r1 = (e(1) |*| 1.0).first!

print("r0 =",r0)
print("r0 =",r1)

let e12 = (e1 |*| e2).first!
let e21 = (e2 |*| e1).first!
//let e23 = e(2) |*| e(3)
let e23 = (e2 |*| e3).first!
let e31 = (e3 |*| e1).first!

print("e12 =",e12)
print("e21 =",e21)
print("e23 =",e23)
print("e31 =",e31)

let e123 = (e12 |*| e3).first!
let e312 = (e3 |*| e12).first!
let e231 = (e23 |*| e1).first!

print("e123 =",e123)
print("e321 =",e312)
print("e231 =",e231)

let e_10 = (10.0 |*| e1).first!
print("e_10 =",e_10)

let e_10_rev = (e1 |*| 10).first!
print("e_10_rev =",e_10_rev)



let e_12 = (11.0 |*| e12).first!
print("e_12 =",e_12)

let e_21 = (e12 |*| 10).first!
print("e_21 =",e_21)


let a = (10, e(1)) |+| ((20, e(2)) |+| (30, e(3)))
print("a =",a)

let b = (100, e(1)) |+| ((200, e(2)) |+| (300, e(3)))
print("b =",b)

print("a |+| b =",a |+| b)

let c = a |+| (400, e(4))
print ("c =",c)

let d =  b |+| a |+| (-300, e(5))
print("d =",d)

let eq = (10 |*| e1) |+| (2 |*| e2)
print("eq =",eq)

let inve1 = Inverse(e(1))
print("inve1 =",inve1)
let inve2 = Inverse(e(2))
print("inve2 =",inve2)

let inve12:(Double, [e]) =  e(1)/e(2)
print("inve12 =",inve12)

let inve12_1:(Double, [e]) =  Inverse(e(1), e(2))
print("inve12_1 =",inve12_1)


let eq1 = (1 |*| e1) |+| (2 |*| e2)
print("eq1 =",eq1)

let eq2 = (3 |*| e1) |+| (4 |*| e2)
print("eq2 =",eq2)

let seq = eq1 |*| eq2
print("eq1 |*| eq2 =",seq.first!)

//
//let e1221 = e12 |*| e21
//print("e1221 = ", e1221)
