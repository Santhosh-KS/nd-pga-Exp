
public func Inverse<A:Numeric>(of basis:(A,e)) -> (A, e) {
  basis
}

public func Inverse<A:Numeric>(of basis:e) -> (A,e) {
  Inverse(of:(1,basis))
}

public func Inverse<A:Numeric>(of basis:(A,[e])) -> (A, [e]) {
  let v = (basis |*| basis).first!
  return v
}

postfix operator |-||

public postfix func |-||<A:Numeric>(_ basis:(A,e)) -> (A, e) {
  basis
}

public postfix func |-||<A:Numeric>(_ basis:e) -> (A, e) {
  (1, basis)|-||
}

public postfix func |-||<A:Numeric>(_ basis:(A, [e])) -> (A, [e]) {
  reverse(of: basis)
}

public postfix func |-||<A:Numeric & FloatingPoint>(_ mulVec:[(A, [e])]) -> [(A, [e])] {
  let nr = mulVec |> map(reverse(of:))
  let dr = grade(with: 0, in: (mulVec |*| nr)).first!.0
  if dr == 0 { fatalError("Divided By Zero Error when finding Inverse for : \(mulVec)") }
  return nr.map { pairs in
    ((pairs.0/dr), pairs.1)
  }
}
