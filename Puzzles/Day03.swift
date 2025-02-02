import Foundation

struct Day03: Solver {
  typealias Input = [Instruction]
  typealias Output = Int

  // TOKENS?
  func parse (_ input: String) -> Input {
    parseTokens(tokenize(input))
  }
  
  func solvePartOne(_ input: Input) -> Output {
    input.sum { instruction in
      return if case let .mul(a, b) = instruction {
        a * b
      }
      else {
        0
      }
    }
  }

  func solvePartTwo(_ input: Input) -> Output {
    var on = true
    var sum = 0

    for instruction in input {
      switch (on, instruction) {
        case (_, .enable): on = true
        case (_, .disable): on = false
        case (true, .mul(let a, let b)): sum += a * b
        default:
          break
      }
    }

    return sum
  }
}

enum Instruction: Equatable {
  case enable
  case disable
  case mul(_ left: Int, _ right: Int)
}

enum Token: Equatable {
  case mul
  case begin_do_or_dont  // do
  case end_dont          // n't
  case open_brace
  case close_brace
  case comma
  case digit(_ digit: Int)
  case garbage // TODO ADD THIS
}

fileprivate func parseTokens (_ inputTokens: [Token]) -> [Instruction] {
  guard inputTokens.nonEmpty else { return [] }

  var tokens = inputTokens
  func consume () -> Token { tokens.removeFirst() }
  func drop (_ count: Int = 1) { tokens.removeFirst(count) }
  func peek (_ offset: Int = 0) -> Token { tokens[offset] }

  func drop_if (_ token: Token) -> Bool {
    guard peek() == token else { return false }

    drop()
    return true
  }

  func consume_all_digits () -> [Int] {
    var digits = [Int]()

    while true {
      if case .digit(let digit) = peek() {
        drop()
        digits.append(digit)
      }
      else {
        break
      }
    }

    return digits
  }

  var state = ParserState.lookingForInstructionName

  var instructions: [Instruction] = [.enable]

  while tokens.nonEmpty {
    switch state {
      case .lookingForInstructionName:
        let token = consume()

        // do()
        if token == .begin_do_or_dont && peek() == .open_brace && peek(1) == .close_brace {
          drop(2)
          instructions.append(.enable)
        }
        // don't()
        else if token == .begin_do_or_dont && peek() == .end_dont && peek(1) == .open_brace && peek(2) == .close_brace {
          drop(3)
          instructions.append(.disable)
        }
        // mul(
        else if token == .mul && peek() == .open_brace {
          drop()
          state = .lookingForMulArguments
        }

      case .lookingForMulArguments:
        let leftDigits = consume_all_digits()
        guard drop_if(.comma) else { state = .lookingForInstructionName; continue }
        let rightDigits = consume_all_digits()
        guard drop_if(.close_brace) else { state = .lookingForInstructionName; continue }

        guard leftDigits.nonEmpty && leftDigits[0] != 0 else { state = .lookingForInstructionName; continue }
        guard rightDigits.nonEmpty && rightDigits[0] != 0 else { state = .lookingForInstructionName; continue }

        instructions.append(.mul(toNumber(leftDigits), toNumber(rightDigits)))
    }
  }

  return instructions
}

fileprivate func toNumber (_ digits: [Int]) -> Int {
  var number = 0

  for digit in digits.reversed().enumerated() {
    number += digit.element * Int(powf(10, Float(digit.offset)))
  }

  return number
}

fileprivate enum ParserState: Equatable {
  case lookingForInstructionName
  case lookingForMulArguments
}

func tokenize (_ input: String) -> [Token] {
  var copy = input
  var tokens = [Token]()
  var garbage = false

  func add_token (_ token: Token, _ length: Int) {
    if garbage {
      tokens.append(.garbage)
      garbage = false
    }

    tokens.append(token)
    copy.removeFirst(min(copy.count, length))
  }

  while copy.nonEmpty {
    if copy.hasPrefix("mul") {
      add_token(Token.mul, 3)
    }
    else if copy.hasPrefix("do") {
      add_token(Token.begin_do_or_dont, 2)
    }
    else if copy.hasPrefix("n't") {
      add_token(Token.end_dont, 3)
    }
    else if copy.first!.isASCII && copy.first!.isNumber {
      add_token(.digit(Int(String(copy.first!))!), 1)
    }
    else {
      switch copy.first! {
        case "(": add_token(.open_brace, 1)
        case ")": add_token(.close_brace, 1)
        case ",": add_token(.comma, 1)
        default:
          garbage = true
          copy.removeFirst(1)
      }
    }
  }

  if garbage {
    tokens.append(.garbage)
  }

  return tokens
}
