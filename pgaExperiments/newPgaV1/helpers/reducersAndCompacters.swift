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

internal func reduce<A>(with f:@escaping (A, A) -> A,
                        _ xs:[(A,e)]) -> [(A,e)] {
  var result = [(A,e)]()
  xs.forEach { pair in
    var index = 0
    if zip((0...),result).contains(where: { indexBvPair in
      index = indexBvPair.0
      let bv = indexBvPair.1
      return bv.1 == pair.1
    }) {
      result[index] = (f(result[index].0, pair.0), pair.1)
    } else {
      result.append(pair)
    }
  }
  return result
}

internal func reduce<A:Numeric>(_ xs:[(A,e)]) -> [(A,e)] {
  var result = [(A,e)]()
  xs.forEach { pair in
    var index = 0
    if zip((0...),result).contains(where: { indexBvPair in
      index = indexBvPair.0
      let bv = indexBvPair.1
      return bv.1 == pair.1
    }) {
      result[index] = (result[index].0 * pair.0, pair.1)
    } else {
      result.append(pair)
    }
  }
  return result
}

internal func removeDuplicates(_ xs:[e]) -> [e] {
  var retVal = [e]()
  for x in xs {
    if retVal.contains(where: { $0 == x }) {
      return []
    } else {
      retVal.append(x)
    }
  }
  return retVal
}

//let reduceAdd: ((A,A) -> A) -> ([(A,e)]) -> [(A,e)]
//let reduceAddition = curry(reduce(with:_:))(|+|)


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
