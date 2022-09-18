import Foundation

let e0 = 1 |*| e(0)
let e1 = 1 |*| e(1)
let e2 = 1 |*| e(2)
let e3 = 1 |*| e(3)
print("e0",e0)
print("e1",e1)
print("e2",e2)
print("e3",e3)

let e00 = e0 |*| e0
let e01 = e0 |*| e1
let e02 = e0 |*| e2
let e03 = e0 |*| e3

print("e00",e00)
print("e01",e01)
print("e02",e02)
print("e03",e03)

let e10 = e1 |*| e0
let e11 = e1 |*| e1
let e12 = e1 |*| e2
let e13 = e1 |*| e3

print("e10",e10)
print("e11",e11)
print("e12",e12)
print("e13",e13)

let e20 = e2 |*| e0
let e21 = e2 |*| e1
let e22 = e2 |*| e2
let e23 = e2 |*| e3

print("e20",e20)
print("e21",e21)
print("e22",e22)
print("e23",e23)

let e30 = e3 |*| e0
let e31 = e3 |*| e1
let e32 = e3 |*| e2
let e33 = e3 |*| e3

print("e30",e30)
print("e31",e31)
print("e32",e32)
print("e33",e33)

let e000 = e00 |*| e0
let e001 = e00 |*| e1
let e002 = e00 |*| e2
let e003 = e00 |*| e3

print("e000", e000)
print("e001", e001)
print("e002", e002)
print("e003", e003)

let e010 = e01 |*| e0
let e011 = e01 |*| e1
let e012 = e01 |*| e2
let e013 = e01 |*| e3

print("e010", e010)
print("e011", e011)
print("e012", e012)
print("e013", e013)

let e020 = e02 |*| e0
let e021 = e02 |*| e1
let e022 = e02 |*| e2
let e023 = e02 |*| e3

print("e020", e020)
print("e021", e021)
print("e022", e022)
print("e023", e023)

let e030 = e03 |*| e0
let e031 = e03 |*| e1
let e032 = e03 |*| e2
let e033 = e03 |*| e3

print("e030", e030)
print("e031", e031)
print("e032", e032)
print("e033", e033)


let grade1 = [e0, e1, e2, e3]
var header = "||"

for x in grade1 {
  header += "\(x.1)|"
}
print(header)
let l = Array<String>.init(repeating: ":---:", count: grade1.count+1).joined(separator: "|")
print(l)
for g in grade1 {
  var k = "|\(g.1) |"
  for i in grade1 {
    k += " \(g |*| i) |"
  }
  print(k)
}
