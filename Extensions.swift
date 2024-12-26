//
// MARK: - Collection
//

extension Collection where Element: AdditiveArithmetic {
  func sum () -> Element {
    reduce(.zero, +)
  }
}
