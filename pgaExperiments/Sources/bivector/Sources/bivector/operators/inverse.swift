
public func Inverse<A:Numeric & FloatingPoint>(of val:A) -> A {
  val|-||
}

public func Inverse<A:Numeric & FloatingPoint>(of basis:(A,e)) -> (A, e) {
  basis|-||
}

public func Inverse<A:Numeric & FloatingPoint>(of basis:e) -> (A,e) {
  basis|-||
}

public func Inverse<A:Numeric & FloatingPoint>(of basis:(A,[e])) -> (A, [e]) {
  basis|-||
}

postfix operator |-||

public postfix func |-||<A:Numeric & FloatingPoint>(_ basis:(A,e)) -> (A, e) {
  (basis.0|-||, basis.1)
}

public postfix func |-||<A:Numeric & FloatingPoint>(_ basis:e) -> (A, e) {
  (1, basis)|-||
}

public postfix func |-||<A:Numeric & FloatingPoint>(_ basis:(A, [e])) -> (A, [e]) {
  let reverse = |~|(A(1), basis.1)
  let reveresedScalar = Inverse(of: basis.0) ||| reverse.0
  return ( reveresedScalar , reverse.1)
}

public postfix func |-||<A:Numeric & FloatingPoint>(_ input:[(A, [e])]) -> [(A, [e])] {
  let conj = input.map(conjugate)
  print("input = ", input)
  print("Conjugate = ", conj)
//  let numerator = input |*| conjugate
//  print("numerator = ", numerator)
  var result = [(A, [e])]()
  let grades:[UInt8] = [0,1,2,3]
  var gc = [(grade:UInt8, constant:A)]()
  for g in grades {
    let vecs = grade(with: g, in: input)
    for vec in vecs {
      let c = vec |*| conjugate(vec)
      print("vec = \(vec): grade = \(g) : \(c)")
      if c.isEmpty {
        gc.append((g, 1))
        result.append((vec.0, []))
      }
      else {
        gc.append((g, c.first!.0))
        result.append((vec.0 |*| Inverse(of:c.first!.0), vec.1))
      }
    }
  }
  return result
}

public postfix func |-||<A:Numeric & FloatingPoint >(_ val:A) -> A {
  if val == 0  { return val }
  return 1/val
}
