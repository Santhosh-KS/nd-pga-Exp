import Foundation

//let a = (10|^|e1)
//let b = (20|^|e2)
//let c = (30|^|e3)
//
//let r = a |+| b
//let z = r |+| c
//
let x1 = 10|^|e1 |+| 10|^|e2 |+| 10|^|e3 |+| 10|^|e4
let x2 = 2.1|^|e2 |+| 3.1|^|e1 |+| 1.3|^|e3 |+| 1.13|^|e4
let x3 = 3.12|^|e3 |+| 1.30|^|e2 |+| 5.5|^|e1 |+| 6.1|^|e4
//
let line = (x1 |^| x2) |> simplify
print(line)

let plane = x1 |^| x2 |^| x3 |> simplify
print(plane)
//let gbx1 = getBaseVectors(line)
//print(gbx1)
//let gbx2 = getBaseVectors(x2)
//let gbx3 = getBaseVectors(x3)
//
//print(e1 |^| e2 |+| e3 |^| e4) // --> Is a 2-vector but not a 2-blade
//print(e1 |^| e2 |+| e2 |^| e1) // --> Is a 2-vector and also a 2-blade
//
//print(grade(gbx1))
//let k = e1 |^| e2 |+| e2 |^| e1
//print(getBaseVectors(k))

//let res = [e(1),e(3),e(2)]
//print(zip2(res, Array(res.dropFirst())))
//print(gbx1)
//print(flipSign(withRef: gbx1, on: [e(3), e(2), e(1)]))
//print(flipSign(forRef: gbx1, on: [e(2), e(3), e(1)]))
//print(flipSign(forRef: gbx1, on: [e(3), e(1), e(2)]))
//print(flipSign(forRef: gbx1, on: [e(2), e(1), e(3)])) // 132, 321, 213, 132, 321, 213

//print(basis([e(1), e(2), e(3), e(4), e(5)]))
//var a = [30,20,10]
//
//func swapCount(_ xs: [Int], _ count:inout Int) -> [Int] {
//  var first = a.first!
//  var res = xs
//  for (idx, val) in zip(1..., res.dropFirst()){
//    if first > val {
//      res.swapAt(idx-1, idx)
//      count += 1
//    }
//    first = val
//  }
//  return res
//}
//
//var count = 0
//print(a, count)
//print(swapCount(a, &count), count)
//
//var b = [10,20,30]
//var res = Array(b.reversed())
//
//while true {
//  let v = swapCount(res, &count)
//  res = v
//  print(res, count)
//  if res == b { break }
//}
//
//print(res)
