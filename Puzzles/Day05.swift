fileprivate extension Array where Element == Int {
  var middle: Int {
    self[count / 2]
  }
}

fileprivate extension Array {
  func reject (_ predicate: (Self.Element) throws  -> Bool) rethrows -> Self {
    try self.filter { try !predicate($0) }
  }
}

struct Day05: Solver {
  struct Input: Equatable {
    let rules: Set<SIMD2<Int>>
    let updates: Array<[Int]>

    fileprivate func sortPredicate (_ left: Int, _ right: Int) -> Bool {
      rules.contains([left, right])
    }

    fileprivate func sort (_ update: [Int]) -> [Int] {
      return update.sorted(by: sortPredicate)
    }

    fileprivate func isOrderedCorrectly (_ update: [Int]) -> Bool {
      for leftIndex in 0..<update.count - 1 {
        for rightIndex in leftIndex + 1..<update.count {
          let left = update[leftIndex]
          let right = update[rightIndex]

          guard !rules.contains([right, left]) else {
            return false
          }
        }
      }

      return true
    }
  }

  typealias Output = Int

  func parse(_ input: String) -> Input {
    let parts = input.split(separator: "\n\n")
    precondition(parts.count == 2)

    let rules = parts.first!
      .split(separator: "\n")
      .map {
        let numbers = $0.split(separator: "|")
        return SIMD2(Int(numbers.first!)!, Int(numbers.last!)!)
      }

    let updates = parts.last!
      .split(separator: "\n")
      .map { $0.split(separator: ",").map({ Int($0)! }) }

    return Input(rules: Set(rules), updates: updates)
  }

  func solvePartOne(_ input: Input) -> Int {
    return input.updates
      .filter(input.isOrderedCorrectly)
      .sum(by: \.middle)
  }

  func solvePartTwo(_ input: Input) -> Int {
    return input.updates
      .reject(input.isOrderedCorrectly)
      .map(input.sort)
      .sum(by: \.middle)
  }
}
