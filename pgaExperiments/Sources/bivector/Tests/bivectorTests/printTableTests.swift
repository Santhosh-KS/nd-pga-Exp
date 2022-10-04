import XCTest

final class printTableTests: XCTestCase {
  
  func testGeometricProductTable() {
    let table:[(Double,[e])] = getTable()
    let geometricTable = tabulate(table, with: |*|).joined(separator: "\n")
    XCTAssertEqual(geometricTable, printGeometricProductTable())
    
    let const_gp = """
    ||e0|e1|e2|e3|e01|e02|e03|e12|e31|e23|e021|e013|e032|e123|e0123|
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
    |e0123 | 0 |e023 | -e013 |e012 | 0 | 0 | 0 | -e03 | -e02 | -e01 | 0 | 0 | 0 | -e0 | 0 |
    """

    XCTAssertEqual(geometricTable, const_gp)
  }
  
  func testInnerProductTable() {
    let table:[(Double,[e])] = getTable()
    let innerProduct = tabulate(table, with: |||).joined(separator: "\n")
    XCTAssertEqual(innerProduct, printInnerProductTable())
    let const_innerproduct =  """
        ||e0|e1|e2|e3|e01|e02|e03|e12|e31|e23|e021|e013|e032|e123|e0123|
        :---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:
        |e0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
        |e1 | 0 |1 | 0 | 0 | -e0 | 0 | 0 |e2 | -e3 | 0 |e02 | -e03 | 0 |e23 | -e023 |
        |e2 | 0 | 0 |1 | 0 | 0 | -e0 | 0 | -e1 | 0 |e3 | -e01 | 0 |e03 | -e13 |e013 |
        |e3 | 0 | 0 | 0 |1 | 0 | 0 | -e0 | 0 |e1 | -e2 | 0 |e01 | -e02 |e12 | -e012 |
        |e01 | 0 |e0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
        |e02 | 0 | 0 |e0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
        |e03 | 0 | 0 | 0 |e0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
        |e12 | 0 | -e2 |e1 | 0 | 0 | 0 | 0 | -1 | 0 | 0 |e0 | 0 | 0 | -e3 | -e03 |
        |e31 | 0 |e3 | 0 | -e1 | 0 | 0 | 0 | 0 | -1 | 0 | 0 |e0 | 0 | -e2 | -e02 |
        |e23 | 0 | 0 | -e3 |e2 | 0 | 0 | 0 | 0 | 0 | -1 | 0 | 0 |e0 | -e1 | -e01 |
        |e021 | 0 |e02 | -e01 | 0 | 0 | 0 | 0 |e0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
        |e013 | 0 | -e03 | 0 |e01 | 0 | 0 | 0 | 0 |e0 | 0 | 0 | 0 | 0 | 0 | 0 |
        |e032 | 0 | 0 |e03 | -e02 | 0 | 0 | 0 | 0 | 0 |e0 | 0 | 0 | 0 | 0 | 0 |
        |e123 | 0 |e23 | -e13 |e12 | 0 | 0 | 0 | -e3 | -e2 | -e1 | 0 | 0 | 0 | -1 |e0 |
        |e0123 | 0 |e023 | -e013 |e012 | 0 | 0 | 0 | -e03 | -e02 | -e01 | 0 | 0 | 0 | -e0 | 0 |
        """
    XCTAssertEqual(const_innerproduct, innerProduct)
  }
  
  func testOuterProductTable() {
    let table:[(Double,[e])] = getTable()
    let outerProduct = tabulate(table, with: |^|).joined(separator: "\n")
    XCTAssertEqual(outerProduct, printOuterProductTable())
    let const_outerProduct = """
    ||e0|e1|e2|e3|e01|e02|e03|e12|e31|e23|e021|e013|e032|e123|e0123|
    :---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:
    |e0 | 0 |e01 |e02 |e03 | 0 | 0 | 0 |e012 | -e013 |e023 | 0 | 0 | 0 |e0123 | 0 |
    |e1 | -e01 | 0 |e12 |e13 | 0 | -e012 | -e013 | 0 | 0 |e123 | 0 | 0 |e0123 | 0 | 0 |
    |e2 | -e02 | -e12 | 0 |e23 |e012 | 0 | -e023 | 0 |e123 | 0 | 0 |e0123 | 0 | 0 | 0 |
    |e3 | -e03 | -e13 | -e23 | 0 |e013 |e023 | 0 |e123 | 0 | 0 |e0123 | 0 | 0 | 0 | 0 |
    |e01 | 0 | 0 |e012 |e013 | 0 | 0 | 0 | 0 | 0 |e0123 | 0 | 0 | 0 | 0 | 0 |
    |e02 | 0 | -e012 | 0 |e023 | 0 | 0 | 0 | 0 |e0123 | 0 | 0 | 0 | 0 | 0 | 0 |
    |e03 | 0 | -e013 | -e023 | 0 | 0 | 0 | 0 |e0123 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    |e12 |e012 | 0 | 0 |e123 | 0 | 0 |e0123 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    |e31 | -e013 | 0 |e123 | 0 | 0 |e0123 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    |e23 |e023 |e123 | 0 | 0 |e0123 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    |e021 | 0 | 0 | 0 | -e0123 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    |e013 | 0 | 0 | -e0123 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    |e032 | 0 | -e0123 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    |e123 | -e0123 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    |e0123 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
    """
    XCTAssertEqual(const_outerProduct, outerProduct)
  }
  
  func testReverseTable() {
    let result = printReverseTable()
    let const_result = """
        ||e0|e1|e2|e3|e01|e02|e03|e12|e31|e23|e021|e013|e032|e123|e0123|
        :---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
        |Reverse|-1.0*e0 | -1.0*e1 | -1.0*e2 | -1.0*e3 | -1.0*e01 | -1.0*e02 | -1.0*e03 | -1.0*e12 | 1.0*e13 | -1.0*e23 | -1.0*e012 | 1.0*e013 | -1.0*e023 | 1.0*e123 | 1.0*e0123|
        """
    XCTAssertEqual(result, const_result)
  }
  
}
