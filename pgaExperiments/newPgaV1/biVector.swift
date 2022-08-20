import Foundation

import Foundation

public struct BiVector {
  let coefficient:Float
  let e:(e,e)
}

public extension BiVector {
  init(_ coef:Float, _ es:(e,e)) {
    coefficient = coef
    e = es
  }
}
