import Testing
import Foundation
@testable import AoC_iOS_swift

@Suite("Day 03") struct Day03_tests {
  @Test func tokenize_works () {
    let input = """
      mul(1,2)
      don't()
      potato_do(not)dance
      """

    #expect(tokenize(input) == [
      .mul, .open_brace, .digit(1), .comma, .digit(2), .close_brace, .garbage,
      .begin_do_or_dont, .end_dont, .open_brace, .close_brace,
      .garbage, .begin_do_or_dont, .open_brace, .garbage, .close_brace, .garbage
    ])
  }

  @Test func parsing_works () {
    let input = """
      mul(1,2)
      don't()
      potato_do(not)dance
      mul(123,123)
      mul(xdo()
      xmul(10,10)
      """

    #expect(Day03().parse(input) == [
      .enable,
      .mul(1, 2),
      .disable,
      .mul(123, 123),
      .enable,
      .mul(10, 10),
    ])
  }

  @Test func example_part1 () {
    let input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

    #expect(Day03().solvePartOne(input) == 161)
  }

  @Test func example_part2 () {
    let input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

    #expect(Day03().solvePartTwo(input) == 48)
  }

  @Test func myinput () {
    let Solver = Day03.self
    let solver = Solver.init()
    let input = solver.parse(Bundle.main.readPuzzleInput(Solver))

    #expect(solver.solvePartOne(input) == 183669043)
    #expect(solver.solvePartTwo(input) == 59097164)
  }
}
