import Foundation

let a = e(0)
print(a)

let bivec:MultiVector<Double> = MultiVector()

print(bivec.basisVectors(e(0), e(0)))
print(bivec.basisVectors(e(1), e(1)))
