fileprivate struct RC: CustomStringConvertible {
  var description: String {
    "r\(row)c\(col)"
  }

  let row: Int
  let col: Int

  var valid: Bool { row >= 0 && col >= 0 }

//  var neighbours: [RC] {
//
//  }

  init (_ row: Int, _ col: Int) {
    self.row = row
    self.col = col
  }

  static func + (rc: RC, offsets: (row: Int, col: Int)) -> RC {
    RC(rc.row + offsets.row, rc.col + offsets.col)
  }

  static let directions = [
    (row: -1, col: -1),
    (row: -1, col:  0),
    (row: -1, col:  1),

    (row: 0, col: -1),
    (row: 0, col:  1),

    (row: 1, col: -1),
    (row: 1, col:  0),
    (row: 1, col:  1),
  ]
}

struct Day04: Solver {
  typealias Input = Array<[Letter]>
  typealias Output = Int

  enum Letter: UInt8, CustomStringConvertible {
    case z = 0
    case X = 2
    case M = 4
    case A = 8
    case S = 16

    var description: String {
      switch self {
        case .X: "X"
        case .M: "M"
        case .A: "A"
        case .S: "S"
        case .z: "."
      }
    }

    static func fromCharacter (_ char: Character) -> Letter {
      switch char {
        case "X": .X
        case "M": .M
        case "A": .A
        case "S": .S
        default: .z
      }
    }
  }

  func parse (_ input: String) -> Input {
    return input
      .split(separator: "\n", omittingEmptySubsequences: true)
      .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines) == $0 }
      .map { $0.map(Letter.fromCharacter) }
  }

  func solvePartOne (_ input: Input) -> Output {
    var count = 0
    for (row, line) in input.enumerated() {
      for (col, letter) in line.enumerated() where letter == .X {
        for dir in RC.directions where [.M, .A, .S] == next3(in: input, startingAt: RC(row, col), following: dir) {
          count += 1
        }
      }
    }

    return count
  }

  func solvePartTwo (_ input: Input) -> Output {
    var count = 0
    for (row, line) in input.enumerated() {
      for (col, letter) in line.enumerated() where letter == .A {
        let topLeft = (-1, -1)
        let topRight = (+1, -1)
        let bottomRight = (+1, +1)
        let bottomLeft = (-1, +1)
        

        let position = RC(row, col)

        if let letterTopLeft = get(position + topLeft, from: input),
           let letterTopRight = get(position + topRight, from: input),
           let letterBottomLeft = get(position + bottomLeft, from: input),
           let letterBottomRight = get(position + bottomRight, from: input),

           letterTopLeft.rawValue + letterBottomRight.rawValue == 20
           &&
           letterTopRight.rawValue + letterBottomLeft.rawValue == 20
        {
          count += 1
        }
      }
    }

    return count
  }

  fileprivate func get (_ rc: RC, from matrix: Input) -> Letter? {
    matrix.elementAt(rc.row)?.elementAt(rc.col)
  }

  fileprivate func next3 (in matrix: Input, startingAt start: RC, following direction: (Int, Int)) -> [Letter] {
    let position1 = start + direction
    let position2 = position1 + direction
    let position3 = position2 + direction

    if let el1 = matrix.elementAt(position1.row)?.elementAt(position1.col),
       let el2 = matrix.elementAt(position2.row)?.elementAt(position2.col),
       let el3 = matrix.elementAt(position3.row)?.elementAt(position3.col)
    {
      return [el1, el2, el3]
    }
    else {
      return []
    }
  }
}
