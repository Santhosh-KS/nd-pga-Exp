import Foundation

enum Domain:UInt8{
  case oneD = 1
  case twoD = 2
  case threeD = 3
  case fourD = 4
}

extension Domain:CustomStringConvertible {
  var description: String {
    "\(self.rawValue)D"
  }
}

