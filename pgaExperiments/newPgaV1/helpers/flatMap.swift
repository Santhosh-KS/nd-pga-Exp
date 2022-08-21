import Foundation


//extension Array {
//  func flatMap<NewElement>(_ f: (Element) -> [NewElement]) -> [NewElement] {
//    var result: [NewElement] = []
//    for element in self {
//      result.append(contentsOf: f(element))
//    }
//    return result
//  }
//}

func flatmap<A>(_ a:[[A]]) -> [A] {
  var retVal = [A]()
  a.forEach { elements in
    retVal.append(contentsOf: elements)
  }
  return retVal
}
