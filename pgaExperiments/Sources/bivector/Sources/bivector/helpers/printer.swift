
import Foundation

func getTable() -> [(Double, [e])] {
  let grade1 = [e0, e1, e2, e3]
  let e123 = e12 |*| e3
  let e0123 = e01 |*| e23
  var table:[(Double, [e])] = grade1.map { ($0.0, [$0.1]) }
  table += [e01, e02, e03, e12, e31, e23]
  table += e012 + e013 + e032 + e123 + e0123
  return table
}

func printGeometricTable() -> String {
  let table:[(Double, [e])] = getTable()
  return tabulate(table, with: |*|).joined(separator: "\n")
}

func printInnerProductTable() -> String {
  let table:[(Double, [e])] = getTable()
  return tabulate(table, with: |||).joined(separator: "\n")
}

func printOuterProductTable() -> String {
  let table:[(Double, [e])] = getTable()
  return tabulate(table, with: |^|).joined(separator: "\n")
}

func shorthand(_ xs:[e]) -> String {
  xs.map { val in "\(val.index)" }.joined(separator: "")
}

func header (_ xs:[[e]]) -> String {
  var header = "||"
 
  for x in xs {  header += "e\(shorthand(x))|"  }
  header += "\n"
  let l = Array<String>.init(repeating: ":---:",
                             count: xs.count+1).joined(separator: "|")
  header += l
  return header
}

func tabulate<A:Numeric & Comparable>(_ xs:[(A,[e])],
                                      with f:(_ lhs:(A,[e]), _ rhs:(A,[e])) -> [(A, [e])])-> [String] {
  var retVal = [String]()
  retVal.append(header(xs.map { $0.1 }))
  
  for g in xs {
    var k = "|e\(shorthand(g.1)) |"
    for i in xs {
      let v = f(g,i)
      if v.isEmpty {
        k += " 0 |"
      } else {
        k += "\((v.first!.0) > A.zero ? "" : "-" )"
        k += (v.first!.1.isEmpty ? "1" : ("e" + "\(shorthand(v.first!.1))")) + "|"
      }
    }
    retVal.append(k)
  }
  return retVal
}

func tabulate<A:Numeric & Comparable>(_ xs:[(A,[e])],
                                      with f:(_ lhs:(A,[e]), _ rhs:(A,[e])) -> (A, [e]))-> [String] {
  var retVal = [String]()
  retVal.append(header(xs.map { $0.1 }))
  
  for g in xs {
    var k = "|e\(shorthand(g.1)) |"
    for i in xs {
      let v = f(g,i)
      if v.0 == 0 {
        k += " 0 |"
      } else {
        k += "\((v.0) > A.zero ? "" : "-" )"
        k += (v.1.isEmpty ? "1" : ("e" + "\(shorthand(v.1))")) + "|"
      }
    }
    retVal.append(k)
  }
  return retVal
}





