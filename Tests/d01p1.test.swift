import Testing
@testable import AoC_iOS_swift

struct AoC_iOS_swiftTests {
  @Test func example1 () {
    let exampleOutput = "11"
    let exampleInput = """
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
      """

    #expect(Puzzles(exampleInput).d01p01() == exampleOutput)
  }

  @Test func example2 () {
    let exampleOutput = "11"
    let exampleInput = """
      13   14
      4   3
      2   5
      1   3
      3   9
      3   3
      """

    #expect(Puzzles(exampleInput).d01p01() == exampleOutput)
  }
}
