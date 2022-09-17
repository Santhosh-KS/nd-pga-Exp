import Foundation

public func customDomain<A:Numeric>() -> A { A.zero + 1 } // e(i)*e(i) = 1 is the current domain

public struct e {
  var index:UInt8
}

public extension e {
  init(_ x:UInt8) {
    index = x
  }
}

extension e:Equatable, Comparable {
  public static func < (lhs: e, rhs: e) -> Bool {
    lhs.index < rhs.index
  }
}

extension e:CustomStringConvertible {
  public var description: String {
    "e(\(self.index))"
  }
}

extension e:Hashable { }

public func sign<A:Numeric>(_ lhs:e, _ rhs:e) -> A {
  if lhs > rhs { return A.zero - 1}
  return A.zero + 1
}

public func sign<A:Numeric>(_ xs:[e]) -> A  {
  let sorted = xs.sorted()
  if xs == sorted { return A.zero + 1 }
  // TODO: Think of better approach than bubblesort
  return bubbleSort(xs)
 
}

func bubbleSort<A:Numeric> (_ xs: [e]) -> A {
  guard xs.count > 1 else { return A.zero + 1}
  var sortedArray = xs
  var retVal:A = A.zero + 1
  for i in 0..<sortedArray.count {
    for j in 0..<sortedArray.count-i-1 {
      if sortedArray[j]>sortedArray[j + 1] {
        sortedArray.swapAt(j + 1, j)
        retVal *= -1
      }
    }
  }
  return retVal
}

enum domain:String {
  case VGA = "VectorSpace Geometric Algebra"
  case STA = "Space Time Algebra"
  case PGA = "Projective Geometric Algebra"
  case CGA = "Conformal Geometric Algebra"
}

