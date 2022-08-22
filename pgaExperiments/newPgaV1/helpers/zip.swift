import Foundation

internal func zip2<A,B>(_ xs:[A], _ ys:[B]) -> [(A,B)] {
  var retVal = [(A,B)]()
  (0..<min(xs.count,ys.count)).forEach { index in
    retVal.append((xs[index], ys[index]))
  }
  return retVal
}

internal func zip3<A,B,C>(_ xs:[A], _ ys:[B], _ zs:[C]) -> [(A,B,C)] {
  zip2(xs, zip2(ys,zs)).map{ a, bc in (a, bc.0, bc.1) }
}

internal func zip2<A,B,C>(with f: @escaping (A,B)->C) -> ([A], [B]) -> [C] {
  return { a, b in zip2(a,b).map(f) }
}

internal func zip3<A,B,C,D>(with f: @escaping (A,B,C)->D) -> ([A], [B], [C]) -> [D] {
  return { a, b, c in zip3(a,b,c).map(f) }
}
