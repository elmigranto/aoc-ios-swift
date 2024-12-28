struct Day02: Solver {
  typealias Input = [[Int]]
  typealias Output = Int

  // TODO: Very inefficient.
  func parse (_ input: String) -> Input {
    return input
      .split(separator: "\n", omittingEmptySubsequences: true)
      .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines) == $0 }
      .map { $0.matches(of: /([1-9]\d*)/).map { Int.init($0.1)! } }
  }

  func solvePartOne (_ input: Input) -> Output {
    return input.count(where: Self.isSafeReport)
  }

  func solvePartTwo (_ input: Input) -> Output {
    return input.count { report in
      return Self.isSafeReport(report)
          || SafetyDampener(report: report).contains(where: Self.isSafeReport)
    }
  }

  private static func isSafeReport (_ report: [Int]) -> Bool {
    guard report.count > 1 else { return true }

    for idx in report.indices.dropLast() {
      let current = report[idx]
      let next = report[idx + 1]
      let safe = 1...3 ~= abs(current - next)

      guard safe else { return false }
    }

    let sorted = report.sorted()
    let asc = report == sorted
    let desc = report.reversed() == sorted

    return true && (asc || desc)
  }
}

/// Returns all permuatuions of `report` with one of the items removed.
fileprivate struct SafetyDampener: IteratorProtocol, Sequence {
  typealias Element = [Int]

  let report: [Int]
  var indexToRemove = -1

  mutating func next () -> Element? {
    indexToRemove += 1
    guard indexToRemove < report.count else { return nil }

    return report.without(elemetAt: indexToRemove)
  }
}
