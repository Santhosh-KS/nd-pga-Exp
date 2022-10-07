import Foundation

internal func flatmap<A>(_ a:[[A]]) -> [A] {
  var retVal = [A]()
  a.forEach { elements in
    if !elements.isEmpty {
      retVal.append(contentsOf: elements)
    }
  }
  return retVal
}

internal func flatmap<A>(sortWith f: (A,A) -> Bool, xs a:[[A]]) -> [A] {
  var retVal = [A]()
  a.forEach { elements in
    if !elements.isEmpty {
      retVal.append(contentsOf: elements)
    }
  }
  return retVal.sorted(by: f)
}

internal func compactMap<A>(_ a:[[A]]) -> [[A]] {
  var retVal = [[A]]()
  a.forEach { vals in
    if !vals.isEmpty {
      retVal.append(vals)
    }
  }
  return retVal
}


internal func compactMap<A:FloatingPoint>(_ xs:[(A, [e])]) -> [(A, [e])] {
  var retVal = [(A,[e])]()
  xs.forEach { pair in
    if pair != zeroVector() {
      if pair.0 != A.zero {
        retVal.append(pair)
      }
    }
  }
  return retVal
}



//internal func removeDuplicates<A>(_ xs:[A], with predicate: @escaping (A,A) -> Bool) -> [A] {
//  var result = [A]()
//  xs.forEach { x in
//    let lp = curry(predicate)(x)
//    if result.contains(where: lp) {
//      result.append(x)
//    }
//  }
//  return result
//}

//public let sortedFlatMap = curry(flatmap(sortWith:xs:))()
