import Foundation

internal func wedge0<A:Numeric>() -> (A,[e]) { (A.zero, []) }

  //[(Double, [e])]
internal func getBaseVectors<A:Numeric>(_ mulVecs:[(A,[e])]) -> [[e]] {
  mulVecs.map { pairs in
    pairs.1.sorted(by: <)
  }
}

internal func getBaseVectors<A:Numeric>(_ mulVecs:[(A,e)]) -> [e] {
  mulVecs.map { pairs in
    pairs.1
  }.sorted(by: <)
}

internal func getBaseVectors<A:Numeric>(_ mulVec:(A,[e])) -> [e] {
  mulVec.1.sorted(by: <)
}

internal func getBaseVectors<A:Numeric>(_ vec:(A,e)) -> e {
  vec.1
}

internal func getBaseVectors(_ vec:e ) -> e {
  vec
}

internal func getBaseVectors<A:Numeric>(_ cons:A ) -> e {
  e(0)
}

internal func basis<A:Numeric>(_ es:[(A, e)]) -> [[(A, e)]] {
  if es.isEmpty { return [es] }
  let first = es.first!
  var dropped  = es.dropFirst()
  dropped.append(first)
  if es.count == 3 {
    return zip2(es, Array(dropped)).map { [$0, $1] }
  } else if es.count == 4 {
    let first  = dropped.first!
    var secondDropped = dropped.dropFirst()
    secondDropped.append(first)
    return zip3(es, Array(dropped), Array(secondDropped)).map { [ $0, $1, $2] }
  } else if es.count == 5 {
    let first  = dropped.first!
    var secondDropped = dropped.dropFirst()
    secondDropped.append(first)
    let second = secondDropped.first!
    var thirdDropped = secondDropped.dropFirst()
    thirdDropped.append(second)
    return zip4(es, Array(dropped), Array(secondDropped), Array(thirdDropped)).map { [ $0, $1, $2, $3] }
  } else {
    fatalError("Basis vector for count >5 is not defined. Currently passed count \(es.count) > 5")
  }
}

internal func basis(_ es:[e]) -> [[e]] {
  if es.isEmpty { return [es] }
  let first = es.first!
  var dropped  = es.dropFirst()
  dropped.append(first)
  if es.count == 3 {
    return zip2(es, Array(dropped)).map { [$0, $1] }
  } else if es.count == 4 {
    let first  = dropped.first!
    var secondDropped = dropped.dropFirst()
    secondDropped.append(first)
    return zip3(es, Array(dropped), Array(secondDropped)).map { [ $0, $1, $2] }
  } else if es.count == 5 {
    let first  = dropped.first!
    var secondDropped = dropped.dropFirst()
    secondDropped.append(first)
    let second = secondDropped.first!
    var thirdDropped = secondDropped.dropFirst()
    thirdDropped.append(second)
    return zip4(es, Array(dropped), Array(secondDropped), Array(thirdDropped)).map { [ $0, $1, $2, $3] }
  } else {
    fatalError("Basis vector for count >5 is not defined. Currently passed count \(es.count) > 5")
  }
}

internal func flipSign(withRef bv:[e], on target:[e]) -> Bool  {
  // TODO: check grade and blade before this logic
  func swapCount(_ xs: [e], _ count:inout UInt8) -> [e] {
    var first = xs.first!
    var res = xs
    for (idx, val) in zip(1..., res.dropFirst()){
      if first > val {
        res.swapAt(idx-1, idx)
        count += 1
      }
      first = val
    }
    return res
  }
  
  var count:UInt8 = 0
  var res = target
  while true {
    let v = swapCount(res, &count)
    res = v
    print(res, count)
    if res == bv { break }
  }
  
//  print(count)
  return count%2 != 0 ? true : false
}

internal func swap<A:Numeric>(_ mulvec:(A, [e])) -> (A, [e]) {
  // TODO: This swap works only multivector with 2 vectors [[e1,e2], [e2,e3]] etc
  // and doesn't work for multivectors for > 2 vectors [[e1,e2,e3], [e2,e3,e1]]
  if mulvec.1.isEmpty { return wedge0() }
  var first = mulvec.1.first!
  var res = mulvec
  for (idx, val) in zip(1..., res.1.dropFirst()){
    if first > val {
      res.1.swapAt(idx-1, idx)
      res.0 *= -1
    }
    first = val
  }
  return res
}
//[(Double, [e])]
internal func simplify<A:Numeric>(_ mulVecs:[(A,[e])]) -> [(A,[e])] {
  reduce(with: |+|, mulVecs.map(swap))
}

//internal func flipSign(forRef bv:[e], on res:[e]) -> Bool {
//  if bv == res { return false }
//  if bv.count != res.count {
//    fatalError("Operations not permitted on basis vectors of different length")
//  }
//  var retVal = false
//  var count = bv.count
//  var res = res
//  while count > 0 {
//    count -= 1
//    let first = res.first!
//    var firstDropped = res.dropFirst()
//    firstDropped.append(first)
//    if Array(firstDropped) == bv {
//      return retVal
//    }
//    retVal.toggle()
//    res = Array(firstDropped)
//  }
//  return retVal
//}

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
                        _ xs:[(A,[e])]) -> [(A,[e])] {
  var result = [(A,[e])]()
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

internal func grade(_ mulVecs:[e]) -> UInt8 {
  mulVecs.sorted(by: <).last!.index
}

internal func complement(_ vec:[e]) -> [e] {
  // NOTE: curryently focusing only on 3D
  if vec.isEmpty { return [e(1), e(2), e(3)] }
  else if vec == [e(1)] { return [e(2), e(3)] }
  else if vec == [e(2)] { return [e(3), e(1)] }
  else if vec == [e(3)] { return [e(1), e(2)] }
  else if vec == [e(2), e(3)] { return [e(1)] }
  else if vec == [e(3), e(1)] { return [e(2)] }
  else if vec == [e(1), e(2)] { return [e(3)] }
  else if vec == [e(1), e(2), e(3)] { return [e(0)] }
  else { return [e(0)] }
}
