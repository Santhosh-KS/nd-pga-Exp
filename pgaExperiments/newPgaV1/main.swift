import Foundation

//print("\(e(UInt8.max))")


////let g1 = (1 |+| 2 |+| 3)
////print("\(g1)")
//print("\(1 |+| 2)")
////print("\(1 |-| 2)")
//print("\((BasisVector(e(1),2)) |+| 1 |+| 2 |+| 3)")
////print("\(1 |-| 2 |-| 3)")
//print("\(1 |+| 2 |+| 3 |+| (BasisVector(e(1),2)))")
////print("\(1 |-| 2 |-| 3 |-| (GeometricNumber(e(1),2)))")
//print("\(1 |+| 2 |+| 3 |+| (BasisVector(e(1),2)) |+| 4)")
////print("\(1 |-| 2 |-| 3 |-| (GeometricNumber(e(1),2)) |-| 4)")
//print("\(1 |+| 2 |+| 3 |+| (BasisVector(e(1),2)) |+| 4 |+| (BasisVector(e(1),2)))")
////print("\(1 |-| 2 |-| 3 |-| (GeometricNumber(e(1),2)) |-| 4 |-| (GeometricNumber(e(1),2)))")


//let e3d = [0,1,2,3] |> map(e.init(index:))
//print(e3d)
//let pga3d = basisVector([10,11,12,13], e3d)
//print(pga3d)
//
//let bvc:[Float] = [1,2,3]
let n1:Float = 2
let n2:Float = .pi
let numbers:[UInt8] = [1,2,3,]
let es = numbers |> map(e.init(index:))
let coeffs = numbers.map { Float($0) }
let arrayPairs = zip2(coeffs, es)
let coeffs1 = numbers.map { 1/Float($0) }
let arrayPairs1 = zip2(coeffs1, es)

print("numbers: \(numbers)")
print("es: \(es)")
print("coefss: \(coeffs)")
print("arrayPairs: \(arrayPairs)")
print("coefss1: \(coeffs1)")
print("arrayPairs1: \(arrayPairs1)")

print(arrayPairs |^| arrayPairs1)

//let appendedArray = arrayPairs + arrayPairs1
//
//print(appendedArray |^| arrayPairs1)

//print(n1|^|n1)
//print(n1|^|e(1))
//print(coeffs|^|es)
//print(es|^|coeffs)
//print(coeffs|^|coeffs)
//print(es|^|es)
//print(es|^|es.reversed())
//print(es|^|es)
//print(coeffs|^|arrayPairs)
//print(arrayPairs|^|coeffs)
//print((arrayPairs.first! |+| arrayPairs.dropFirst().first!) |^|
//      (arrayPairs.last! |+| arrayPairs.dropFirst().first!) |^|
//      (arrayPairs.dropFirst().first! |+| arrayPairs.dropFirst().first!))
