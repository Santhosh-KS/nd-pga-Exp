import Foundation

internal let wedge0:(Float,[e]) = (0,[])

internal func reduce(_ xs: [(Float, [e])]) -> (Float, [e]) {
  var prod:Float = 1
  xs.forEach { (val:Float, _) in
    prod *= val
  }
  return (prod, [])
}

internal func reduce(_ xs: [(Float, [e])]) -> [(Float, [e])] {
  var compactResult = [(Float,[e])]()
  if xs.isEmpty { return compactResult }
  var previousPairs:(Float,[e]) = xs.first!
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

internal func compact(_ xs:[(Float, [e])]) -> [(Float, [e])] {
  var retVal = [(Float,[e])]()
  xs.forEach { pair in
    if pair != wedge0 {
      retVal.append(pair)
    }
  }
  return retVal
}

internal func grade(_ mvs:(Float, [e])) -> UInt8 {
  if mvs.1.isEmpty { return 0}
  return mvs.1.max()!.index
}


fileprivate func antiCommute(_ lhs:(Float,e), _ rhs:(Float,e)) -> (Float,[e]) {
  (-1*rhs.0, rhs.1) |^| lhs
}

fileprivate func antiCommute(_ lhs:[(Float,e)], _ rhs:[(Float,e)]) -> [(Float,[e])] {
  zip2(with: antiCommute)(lhs, rhs) |> (compact >>> reduce)
}
