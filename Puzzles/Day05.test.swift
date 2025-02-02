import Testing
import Foundation
@testable import AoC_iOS_swift

@Suite("Day 05") struct Day05_tests {
  @Test func parse_input () {
    let sample = """
      2|1
      4|3
      6|5
      
      1,2,3
      4,5,6
      """

    #expect(Day05().parse(sample) == Day05.Input(
      rules: [
        [2, 1],
        [4, 3],
        [6, 5],
      ],
      updates: [
        [1, 2, 3],
        [4, 5, 6],
      ]
    ))
  }

  @Test func solve_sample () {
    let sample = """
      47|53
      97|13
      97|61
      97|47
      75|29
      61|13
      75|53
      29|13
      97|29
      53|29
      61|53
      97|53
      61|29
      47|13
      75|47
      97|75
      47|61
      75|61
      47|29
      75|13
      53|13
      
      75,47,61,53,29
      97,61,53,29,13
      75,29,13
      75,97,47,61,53
      61,13,29
      97,13,75,29,47
      """

    #expect(Day05().solvePartOne(sample) == 143)
  }

  @Test func myinput () {
    let Solver = Day05.self
    let solver = Solver.init()
    let input = solver.parse(Bundle.main.readPuzzleInput(Solver))

    #expect(solver.solvePartOne(input) == 5087)
    #expect(solver.solvePartTwo(input) == 4971)
  }
}
