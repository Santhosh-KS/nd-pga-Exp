import Foundation

prefix operator |~|

prefix func |~|<A:Numeric>(_ item:(A,[e])) -> (A,[e]) {
  if item.1.isEmpty { return (1, []) }
  let val = normalized(item)
  if grade(item) == 3 && item.1 == val.1 { return item }
  return (val.0 * -1, val.1 )
}

prefix func |~|<A:Numeric>(_ item:(A,e)) -> (A,e) {
  return (item.0 * -1, item.1)
}

prefix func |~|<A:Numeric>(_ item:e) -> (A,e) {
  |~|(1, item)
}

prefix func |~|<A:Numeric>(_ item:A) -> A {
  item
}
