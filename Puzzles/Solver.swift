protocol Solver {
  associatedtype Input
  associatedtype Output

  init ()
  func parse (_ input: String) -> Input

  //
  // Required.
  //

  func solvePartOne (_ input: Input) -> Output
  func solvePartTwo (_ input: Input) -> Output

  //
  // Have defaults.
  //

  func solvePartOne (_ input: String) -> Output
  func solvePartTwo (_ input: String) -> Output

  func solvePartOne (_ input: String) -> String
  func solvePartTwo (_ input: String) -> String
}

// MARK: - Default implementations

extension Solver {
  func solvePartOne (_ input: String) -> Output {
    solvePartOne(parse(input))
  }

  func solvePartTwo (_ input: String) -> Output {
    solvePartTwo(parse(input))
  }

  func solvePartOne (_ input: String) -> String {
    let out: Output = solvePartOne(input)
    return String(describing: out)
  }

  func solvePartTwo (_ input: String) -> String {
    let out: Output = solvePartTwo(input)
    return String(describing: out)
  }
}
