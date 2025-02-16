fileprivate struct RC: Hashable {
  let row: Int
  let col: Int

  init (_ row: Int, _ col: Int) {
    self.row = row
    self.col = col
  }
}

struct Bytes2d: Equatable {
  let width: Int
  let height: Int
  private var data: [UInt8]

  init (width: Int, height: Int) {
    self.width = width
    self.height = height
    self.data = [UInt8](repeating: 0, count: width * height)
  }

  fileprivate subscript (_ position: RC) -> UInt8 {
    get { self[position.row, position.col] }
    set { self[position.row, position.col] = newValue }
  }

  subscript (_ row: Int, _ col: Int) -> UInt8 {
    get { data[row * height + col] }
    set { data[row * height + col] = newValue }
  }
}

extension Bytes2d: ExpressibleByArrayLiteral {
  typealias ArrayLiteralElement = [UInt8]
  init (arrayLiteral elements: ArrayLiteralElement...) {
    self.init(width: elements[0].count, height: elements.count)

    for (row, line) in elements.enumerated() {
      for (col, byte) in line.enumerated() {
        self[row, col] = byte
      }
    }
  }
}

struct Day06: Solver {
  struct Map: CustomStringConvertible {
    let rawMap: String
    var map: Bytes2d
    fileprivate var start: RC

    init (_ rawMap: String) {
      let lines = rawMap.split(separator: "\n", omittingEmptySubsequences: true)

      var start = RC(0, 0)
      var map = Bytes2d(
        width: lines[0].count,
        height: lines.count
      )

      for (row, line) in lines.enumerated() {
        for (col, char) in line.enumerated() {
          if char == "#" {
            map[row, col] = 1
          }
          else if char == "^" {
            start = RC(row, col)
          }
        }
      }

      self.rawMap = rawMap
      self.map = map
      self.start = start
    }

    fileprivate func walk (from start: RC, startingIn startingDirection: Direction) -> MapEnd {
      var position = start
      var direction = startingDirection
      var visited = [RC: Set<Direction>]()

      while true {
        if visited[position, default: []].contains(direction) {
          return .loop
        }

        visited[position, default: []].insert(direction)

        let next = position + direction
        switch self[next] {
          case .outOfBounds: return .outOfBounds
          case .obstacle: direction += 1
          case .emptySpace: position = next
        }
      }

      fatalError("Supposed to return before")
    }

    var description: String { rawMap }

    enum MapEnd {
      case loop
      case outOfBounds
    }

    enum MapItem {
      case emptySpace
      case obstacle
      case outOfBounds
    }

    fileprivate subscript (_ rc: RC) -> MapItem {
      get {
        guard 0..<map.height ~= rc.row && 0..<map.width ~= rc.col else { return .outOfBounds }
        return map[rc] == 1 ? .obstacle : .emptySpace
      }

      set {
        precondition(newValue != .outOfBounds && self[rc] != .outOfBounds)
        map[rc] = newValue == .obstacle ? 1 : 0
      }
    }
  }

  enum Direction: Int {
    case up = 0
    case right = 1
    case down = 2
    case left = 3

    var opposite: Direction {
      self + 2
    }

    static func + (direction: Direction, int: Int) -> Direction {
      Direction(rawValue: (direction.rawValue + int) % 4).unsafelyUnwrapped
    }

    static func += (direction: inout Direction, int: Int) {
      direction = direction + 1
    }

    fileprivate static func + (position: RC, direction: Direction) -> RC {
      return switch direction {
        case .up: RC(position.row - 1, position.col)
        case .right: RC(position.row, position.col + 1)
        case .down: RC(position.row + 1, position.col)
        case .left: RC(position.row, position.col - 1)
      }
    }

    fileprivate static func += (position: inout RC, direction: Direction) {
      position = position + direction
    }
  }

  typealias Input = Map
  typealias Output = Int

  func parse (_ input: String) -> Input {
    return Map(input)
  }

  func solvePartOne (_ map: Input) -> Output {
    var direction = Direction.up
    var position = map.start
    var visited = Set<RC>()

    loop: while true {
      visited.insert(position)
      let next = position + direction

      switch map[next] {
        case .emptySpace: position = next
        case .outOfBounds: break loop
        case .obstacle: direction += 1
      }
    }

    return visited.count
  }

  func solvePartTwo (_ map: Input) -> Output {
    var position = map.start
    var direction = Direction.up
    var obstacles = Set<RC>()

    loop: while true {
      let next = position + direction

      switch map[next] {
        case .emptySpace:
          if position + direction != map.start && !obstacles.contains(next) {
            var mapWithObstacle = map
            mapWithObstacle[next] = .obstacle

            // TODO: This used to check (from: position, startingIn: direction), but had false positives.
            if mapWithObstacle.walk(from: map.start, startingIn: Direction.up) == .loop {
              obstacles.insert(next)
            }
          }

          position = next

        case .outOfBounds: break loop
        case .obstacle: direction += 1
      }
    }

    return obstacles.count
  }
}
