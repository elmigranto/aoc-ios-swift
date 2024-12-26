import Testing
@testable import AoC_iOS_swift

struct AoC_iOS_Day01_Tests {
  @Test func part1_example1 () {
    let exampleOutput = 11
    let exampleInput = """
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
      """

    #expect(Day01().solvePartOne(exampleInput) == exampleOutput)
  }

  @Test func part1_example2 () {
    let exampleOutput = 11
    let exampleInput = """
      13   14
      4   3
      2   5
      1   3
      3   9
      3   3
      """

    #expect(Day01().solvePartOne(exampleInput) == exampleOutput)
  }

  @Test func part2_example1 () {
    let exampleOutput = 31
    let exampleInput = """
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
      """

    #expect(Day01().solvePartTwo(exampleInput) == exampleOutput)
  }
}
