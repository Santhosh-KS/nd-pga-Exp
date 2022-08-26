import Foundation

internal func wedge0<A:Numeric>() -> (A,[e]) { (A.zero, []) }

internal func reduce<A:Numeric>(toMultivector xs: [(A, [e])]) -> [(A, [e])] {
  var compactResult = [(A,[e])]()
  if xs.isEmpty { return compactResult }
  var previousPairs:(A,[e]) = xs.first!
  var prod = previousPairs.0
  xs.dropFirst().forEach { currentPairs in
    if currentPairs.1 == previousPairs.1 {
      prod *= currentPairs.0
    } else {
      compactResult.append(previousPairs)
    }
    previousPairs = currentPairs
  }
  compactResult.append(previousPairs)
  return compactResult
}

//internal func compact<A:Numeric>(_ xs:[(A, [e])]) -> [(A, [e])] {
//  var retVal = [(A,[e])]()
//  xs.forEach { pair in
//    if pair != wedge0() {
//      retVal.append(pair)
//    }
//  }
//  return retVal
//}

internal func grade<A:Numeric>(_ mvs:(A, [e])) -> UInt8 {
  if mvs.1.isEmpty { return 0}
  return mvs.1.max()!.index
}


//fileprivate func antiCommute<A:Numeric>(_ lhs:(A,e), _ rhs:(A,e)) -> (A,[e]) {
//  (-1*rhs.0, rhs.1) |^| lhs
//}

//fileprivate func antiCommute<A:Numeric>(_ lhs:[(A,e)], _ rhs:[(A,e)]) -> [(A,[e])] {
//  zip2(with: antiCommute)(lhs, rhs) |> (compact >>> reduce)
//}
