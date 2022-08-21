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


let e3d = [0,1,2,3] |> map(e.init(index:))
print(e3d)
let pga3d = basisVector([10,11,12,13], e3d)
print(pga3d)
