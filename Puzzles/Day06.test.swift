import Testing
import Foundation
@testable import AoC_iOS_swift

@Suite("Day 06") struct Day06_tests {
  @Test func parse_input () {
    let sample = """
      ..#
      .#.
      #..
      """

    let expected: Bytes2d = [
      [0, 0, 1],
      [0, 1, 0],
      [1, 0, 0]
    ]

    #expect(Day06().parse(sample).map == expected)
  }

  @Test func sample_data_part_one () {
    let sample = """
      ....#.....
      .........#
      ..........
      ..#.......
      .......#..
      ..........
      .#..^.....
      ........#.
      #.........
      ......#...
      """

    #expect(Day06().solvePartOne(sample) == 41)
    #expect(Day06().solvePartTwo(sample) == 6)
  }

  @Test func myinput () {
    let Solver = Day06.self
    let solver = Solver.init()
    let input = solver.parse(Bundle.main.readPuzzleInput(Solver))

    #expect(solver.solvePartOne(input) == 5461)
    #expect(solver.solvePartTwo(input) == 1836)
  }
}
