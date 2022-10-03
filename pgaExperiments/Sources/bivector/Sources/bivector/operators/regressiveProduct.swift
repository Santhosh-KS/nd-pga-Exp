precedencegroup RegressiveProductProcessingOrder {
  associativity:left
  higherThan: AdditionEvaluation, ForwardApplication, SandwichProductProcessingOrder
  lowerThan: MultiplicationPrecedence, AdditionPrecedence
}

infix operator |^*|:RegressiveProductProcessingOrder

public func |^*|<A:Numeric & FloatingPoint>(_ lhs:A, _ rhs:A) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}

public func |^*|<A:Numeric & FloatingPoint>(_ lhs:[A], _ rhs:[A]) -> (A, [e]) {
  dual(dual(rhs.reduce(1,*)) |^| dual(lhs.reduce(1, *)))
}

public func |^*|<A:Numeric & FloatingPoint>(_ lhs:A, _ rhs:e) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}

public func |^*|<A:Numeric & FloatingPoint>(_ lhs:e, _ rhs:A) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}

public func |^*|<A:Numeric & FloatingPoint>(_ lhs:A, _ rhs:(A,e)) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}

public func |^*|<A:Numeric & FloatingPoint>(_ lhs:(A,e), _ rhs:A) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}

public func |^*|<A:Numeric & FloatingPoint>(_ lhs:(A,e), _ rhs:e) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}

public func |^*|<A:Numeric & FloatingPoint>(_ lhs:e, _ rhs:(A,e)) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}

public func |^*|<A:Numeric & FloatingPoint>(_ lhs:(A,e), _ rhs:(A,e)) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}

public func |^*|<A:Numeric & FloatingPoint>(_ lhs:(A,[e]), _ rhs:(A,[e])) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}

public func |^*|<A:Numeric & FloatingPoint>(_ lhs:(A,e), _ rhs:(A,[e])) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}

public func |^*|<A:Numeric & FloatingPoint>(_ lhs:(A,[e]), _ rhs:(A,e)) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}

public func |^*|<A:Numeric & FloatingPoint>(_ lhs:[(A,[e])], _ rhs:[(A,[e])]) -> [(A, [e])] {
  dual(reduce(with: |+|, dual(rhs) |^| dual(lhs)))
}
      
public func |^*| <A:Numeric & FloatingPoint>(_ lhs: e, _ rhs: e) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}

public func |^*| <A:Numeric & FloatingPoint>(_ lhs: (A, [e]), _ rhs: e) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}
                          
public func |^*| <A:Numeric & FloatingPoint>(_ lhs: e, _ rhs: (A, [e])) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}
                            
public func |^*| <A:Numeric & FloatingPoint>(_ lhs: (A, [e]), _ rhs: [e]) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}
                              
public func |^*| <A:Numeric & FloatingPoint>(_ lhs: [e], _ rhs: (A, [e])) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}
                                
public func |^*| <A:Numeric & FloatingPoint>(_ lhs: [e], _ rhs: [e]) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}
                                  
public func |^*| <A:Numeric & FloatingPoint>(_ lhs: A, _ rhs: (A, [e])) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}
                                    
public func |^*| <A:Numeric & FloatingPoint>(_ lhs: (A, [e]), _ rhs: A) -> (A, [e]) {
  dual(dual(rhs) |^| dual(lhs))
}

public func |^*| <A:Numeric & FloatingPoint>(_ lhs: [A], _ rhs: e) -> (A, [e]) {
  dual(rhs) |^| dual(lhs.reduce(1, *))
}

public func |^*| <A:Numeric & FloatingPoint>(_ lhs: e, _ rhs: [A]) -> (A, [e]) {
  dual(rhs.reduce(1, *)) |^| dual(lhs)
}

