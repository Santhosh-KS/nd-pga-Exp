import Foundation

internal func flatmap<A>(_ a:[[A]]) -> [A] {
  var retVal = [A]()
  a.forEach { elements in
    retVal.append(contentsOf: elements)
  }
  return retVal
}

internal func flatmap<A>(sortWith f: (A,A) -> Bool, xs a:[[A]]) -> [A] {
  var retVal = [A]()
  a.forEach { elements in
    retVal.append(contentsOf: elements)
  }
  return retVal.sorted(by: f)
}

//public let sortedFlatMap = curry(flatmap(sortWith:xs:))()
