let e0 = (1.0 |*| e(0)).first!
let e1 = (1.0 |*| e(1)).first!
let e2 = (1.0 |*| e(2)).first!
let e3 = (1.0 |*| e(3)).first!
let e4 = (1.0 |*| e(4)).first!

print(e0)
print(e1)
print(e2)
print(e3)
print(e4)

let r0 = (e(0) |*| 1.0).first!
let r1 = (e(1) |*| 1.0).first!

print(r0)
print(r1)

let e12 = (e1 |*| e2).first!
//let e23 = e(2) |*| e(3)
let e23 = (e2 |*| e3).first!
let e31 = (e3 |*| e1).first!

print(e12)
print(e23)
print(e31)

let e123 = (e12 |*| e3).first!
let e312 = (e3 |*| e12).first!
let e231 = (e23 |*| e1).first!

print(e123)
print(e312)
print(e231)

let e_10 = (10.0 |*| e1).first!
print(e_10)

let e_10_rev = (e1 |*| 10).first!
print(e_10_rev)

let a = (10, e(1)) |+| ((20, e(2)) |+| (30, e(3)))
print(a)

let e_12 = (11.0 |*| e12).first!
print(e_12)

let e_21 = (e12 |*| 10).first!
print(e_21)
