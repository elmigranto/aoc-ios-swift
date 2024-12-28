import Testing
import Foundation
@testable import AoC_iOS_swift

@Suite("Day 02") struct Day02Tests {
  @Test func parsing_works () {
    #expect(Day02().parse("1 2 3\n") == [[1, 2, 3]])
    #expect(Day02().parse("1 2 3\n10 10 10\n\n   ") == [[1, 2, 3], [10, 10, 10]])
  }

  @Test func example_part1 () {
    let output = 2
    let input = """
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      1 3 2 4 5
      8 6 4 4 1
      1 3 6 7 9
      """

    #expect(Day02().solvePartOne(input) == output)
  }

  @Test func example_part2 () {
    let output = 4
    let input = """
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      1 3 2 4 5
      8 6 4 4 1
      1 3 6 7 9
      """

    #expect(Day02().solvePartTwo(input) == output)
  }

  @Test func myinput () {
    let Solver = Day02.self
    let solver = Solver.init()
    let input = solver.parse(Bundle.main.readPuzzleInput(Solver))

    #expect(solver.solvePartOne(input) == 282)
    #expect(solver.solvePartTwo(input) == 349)
  }
}
