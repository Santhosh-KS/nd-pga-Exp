
import Foundation

func getTable() -> [(Double, [e])] {
//  let grade1 = [(1, [e(0)]), (1, [e(1)]), (1, [e(2)]), (1, [e(3)])]
  var table:[(Double, [e])] = [(1, [e(0)]), (1, [e(1)]), (1, [e(2)]), (1, [e(3)])]
  table += [(1,[e(0), e(1)]),
            (1,[e(0), e(2)]),
            (1,[e(0), e(3)]),
            (1,[e(1), e(2)]),
            (1,[e(3), e(1)]),
            (1,[e(2), e(3)])]
  table += [(1,[e(0), e(2), e(1)]),
            (1,[e(0), e(1),e(3)]),
            (1,[e(0), e(3), e(2)]),
            (1,[e(1), e(2), e(3)]),
            (1,[e(0), e(1), e(2), e(3)])]
  return table
}

func printGeometricProductTable() -> String {
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

func printRegressiveProductTable() -> String {
  let table:[(Double, [e])] = getTable()
  return tabulate(table, with: |^*|).joined(separator: "\n")
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
        k += "\((v.first!.0) > A.zero ? "" : " -" )"
        k += (v.first!.1.isEmpty ? "1" : ("e" + "\(shorthand(v.first!.1))")) + " |"
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
        k += "\((v.0) > A.zero ? "" : " -" )"
        k += (v.1.isEmpty ? "1" : ("e" + "\(shorthand(v.1))")) + " |"
      }
    }
    retVal.append(k)
  }
  return retVal
}

func stringify<A:Numeric>(_ vec:(A, [e])) -> String {
  "\(vec.0)*e\(vec.1.map { String($0.index) }.joined())"
}

func stringify<A:Numeric>(_ vec:(A, e)) -> String {
  stringify((vec.0, [vec.1]))
}

func stringify<A:Numeric>(_ vecs:[(A, [e])]) -> String {
  vecs.map(stringify).joined(separator: " + ")
}


/*
 ("||e|e1|e2|e3|e01|e02|e03|e12|e31|e23|e021|e013|e032|e123|e0123|
 :---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:
 |e |1 |e1 |e2 |e3 |e01 |e02 |e03 |e12 | -e13 |e23 | -e012 |e013 | -e023 |e123 |e0123 |
 |e1 |e1 |1 |e12 |e13 | -e0 | -e012 | -e013 |e2 | -e3 |e123 |e02 | -e03 |e0123 |e23 | -e023 |
 |e2 |e2 | -e12 |1 |e23 |e012 | -e0 | -e023 | -e1 |e123 |e3 | -e01 |e0123 |e03 | -e13 |e013 |
 |e3 |e3 | -e13 | -e23 |1 |e013 |e023 | -e0 |e123 |e1 | -e2 |e0123 |e01 | -e02 |e12 | -e012 |
 |e01 |e01 |e0 |e012 |e013 | 0 | 0 | 0 |e02 | -e03 |e0123 | 0 | 0 | 0 |e023 | 0 |
 |e02 |e02 | -e012 |e0 |e023 | 0 | 0 | 0 | -e01 |e0123 |e03 | 0 | 0 | 0 | -e013 | 0 |
 |e03 |e03 | -e013 | -e023 |e0 | 0 | 0 | 0 |e0123 |e01 | -e02 | 0 | 0 | 0 |e012 | 0 |
 |e12 |e12 | -e2 |e1 |e123 | -e02 |e01 |e0123 | -1 |e23 |e13 |e0 | -e023 | -e013 | -e3 | -e03 |
 |e31 | -e13 |e3 |e123 | -e1 |e03 |e0123 | -e01 | -e23 | -1 |e12 |e023 |e0 | -e012 | -e2 | -e02 |
 |e23 |e23 |e123 | -e3 |e2 |e0123 | -e03 |e02 | -e13 | -e12 | -1 |e013 |e012 |e0 | -e1 | -e01 |
 |e021 | -e012 |e02 | -e01 | -e0123 | 0 | 0 | 0 |e0 | -e023 | -e013 | 0 | 0 | 0 |e03 | 0 |
 |e013 |e013 | -e03 | -e0123 |e01 | 0 | 0 | 0 |e023 |e0 | -e012 | 0 | 0 | 0 |e02 | 0 |
 |e032 | -e023 | -e0123 |e03 | -e02 | 0 | 0 | 0 |e013 |e012 |e0 | 0 | 0 | 0 |e01 | 0 |
 |e123 |e123 |e23 | -e13 |e12 | -e023 |e013 | -e012 | -e3 | -e2 | -e1 | -e03 | -e02 | -e01 | -1 |e0 |
 |e0123 |e0123 |e023 | -e013 |e012 | 0 | 0 | 0 | -e03 | -e02 | -e01 | 0 | 0 | 0 | -e0 | 0 |")
 */

/*
 ("||e0|e1|e2|e3|e01|e02|e03|e12|e31|e23|e021|e013|e032|e123|e0123|
 :---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:
 |e0 | 0 |e01 |e02 |e03 | 0 | 0 | 0 |e012 | -e013 |e023 | 0 | 0 | 0 |e0123 | 0 |
 |e1 | -e01 |1 |e12 |e13 | -e0 | -e012 | -e013 |e2 | -e3 |e123 |e02 | -e03 |e0123 |e23 | -e023 |
 |e2 | -e02 | -e12 |1 |e23 |e012 | -e0 | -e023 | -e1 |e123 |e3 | -e01 |e0123 |e03 | -e13 |e013 |
 |e3 | -e03 | -e13 | -e23 |1 |e013 |e023 | -e0 |e123 |e1 | -e2 |e0123 |e01 | -e02 |e12 | -e012 |
 |e01 | 0 |e0 |e012 |e013 | 0 | 0 | 0 |e02 | -e03 |e0123 | 0 | 0 | 0 |e023 | 0 |
 |e02 | 0 | -e012 |e0 |e023 | 0 | 0 | 0 | -e01 |e0123 |e03 | 0 | 0 | 0 | -e013 | 0 |
 |e03 | 0 | -e013 | -e023 |e0 | 0 | 0 | 0 |e0123 |e01 | -e02 | 0 | 0 | 0 |e012 | 0 |
 |e12 |e012 | -e2 |e1 |e123 | -e02 |e01 |e0123 | -1 |e23 |e13 |e0 | -e023 | -e013 | -e3 | -e03 |
 |e31 | -e013 |e3 |e123 | -e1 |e03 |e0123 | -e01 | -e23 | -1 |e12 |e023 |e0 | -e012 | -e2 | -e02 |
 |e23 |e023 |e123 | -e3 |e2 |e0123 | -e03 |e02 | -e13 | -e12 | -1 |e013 |e012 |e0 | -e1 | -e01 |
 |e021 | 0 |e02 | -e01 | -e0123 | 0 | 0 | 0 |e0 | -e023 | -e013 | 0 | 0 | 0 |e03 | 0 |
 |e013 | 0 | -e03 | -e0123 |e01 | 0 | 0 | 0 |e023 |e0 | -e012 | 0 | 0 | 0 |e02 | 0 |
 |e032 | 0 | -e0123 |e03 | -e02 | 0 | 0 | 0 |e013 |e012 |e0 | 0 | 0 | 0 |e01 | 0 |
 |e123 | -e0123 |e23 | -e13 |e12 | -e023 |e013 | -e012 | -e3 | -e2 | -e1 | -e03 | -e02 | -e01 | -1 |e0 |
 |e0123 | 0 |e023 | -e013 |e012 | 0 | 0 | 0 | -e03 | -e02 | -e01 | 0 | 0 | 0 | -e0 | 0 |")
 */
