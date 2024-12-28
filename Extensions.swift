import Foundation

//
// MARK: - Collection
//

extension Collection where Element: AdditiveArithmetic {
  func sum () -> Element {
    reduce(.zero, +)
  }
}

extension Array {
  func without (elemetAt index: Index) -> Self {
    var copy = self
    copy.remove(at: index)
    return copy
  }
}

//
// MARK: - Bundle
//

extension Bundle {
  func readPuzzleInput (_ Solver: any Solver.Type) -> String {
    let puzzleId = String(describing: Solver)
    let url = Bundle.main.url(forResource: puzzleId, withExtension: "txt")!

    return try! String(contentsOf: url, encoding: .utf8)
  }
}
