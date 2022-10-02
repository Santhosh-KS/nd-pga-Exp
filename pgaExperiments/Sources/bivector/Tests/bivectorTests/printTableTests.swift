import XCTest

final class printTableTests: XCTestCase {
  
  func testGeometricProductTable() {
    let table:[(Double,[e])] = getTable()
    let geometricTable = tabulate(table, with: |*|).joined(separator: "\n")
    XCTAssertEqual(geometricTable, printGeometricProductTable())
  }
  
  func testInnerProductTable() {
    let table:[(Double,[e])] = getTable()
    let geometricTable = tabulate(table, with: |||).joined(separator: "\n")
    XCTAssertEqual(geometricTable, printInnerProductTable())
  }
  
  func testOuterProductTable() {
    let table:[(Double,[e])] = getTable()
    let geometricTable = tabulate(table, with: |^|).joined(separator: "\n")
    XCTAssertEqual(geometricTable, printOuterProductTable())
  }
  
}
