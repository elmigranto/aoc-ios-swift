import Testing
import Foundation
@testable import AoC_iOS_swift

@Suite("Day 04") struct Day04_tests {
  @Test func parse_input () {
    let input = """
      XMAS
      MMFF
      ALAR
      SPPS
      """

    let output: Day04.Input = [
      [.X, .M, .A, .S],
      [.M, .M, .z, .z],
      [.A, .z, .A, .z],
      [.S, .z, .z, .S],
    ]

    #expect(Day04().parse(input) == output)
  }

  @Test func solve_one () {
    let solved: Day04.Output = Day04().solvePartOne("""
      MMMSXXMASM
      MSAMXMSMSA
      AMXSXMAAMM
      MSAMASMSMX
      XMASAMXAMM
      XXAMMXXAMA
      SMSMSASXSS
      SAXAMASAAA
      MAMMMXMMMM
      MXMXAXMASX
      """
    )

    #expect(solved == 18)
  }

  @Test func myinput () {
    let Solver = Day04.self
    let solver = Solver.init()
    let input = solver.parse(Bundle.main.readPuzzleInput(Solver))

    #expect(solver.solvePartOne(input) == 2599)
    #expect(solver.solvePartTwo(input) == 1948)
  }
}
