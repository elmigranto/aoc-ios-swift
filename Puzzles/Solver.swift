protocol Solver {
  associatedtype Input
  associatedtype Output

  init ()
  func parse (_ input: String) -> Input
  func solve (_ input: Input) -> Output

  func solve (_ input: String) -> Output
  func solve (_ input: String) -> String
}

extension Solver {
  func solve (_ input: String) -> Output {
    solve(parse(input))
  }

  func solve (_ input: String) -> String {
    let out: Output = solve(input)
    return String(describing: out)
  }
}
