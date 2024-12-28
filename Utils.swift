//
// MARK: - pp
//

func pp<T> (_ val: T) -> T {
  print(val)
  return val
}

func pp<T> (_ prefix: String, _ val: T) -> T {
  print("\(prefix):", val)
  return val
}

//
// MARK: - fn1 | fn2
//

precedencegroup CompositionPrecedence {
  associativity: left
}

infix operator |: CompositionPrecedence

func | <T, U, V> (lhs: @escaping (T) -> U, rhs: @escaping (U) -> V) -> (T) -> V {
  return { rhs(lhs($0)) }
}

//
// MARK: - chunked
//

extension Collection where Index == Int {
  func chunked (into size: Int) -> [[Element]] {
    return stride(from: 0, to: count, by: size).map {
      Array(self[$0 ..< Swift.min($0 + size, count)])
    }
  }
}
