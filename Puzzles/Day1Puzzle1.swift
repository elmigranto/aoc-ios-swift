//fileprivate let plus: (Int, Int) -> Int = (+)
fileprivate let minus: (Int, Int) -> Int = (-)
//fileprivate func unwrap<T> (_ value: T?) -> T { value! }
//
//
//func minus<T: AdditiveArithmetic> (left: T, right: T) -> T {
//  left - right
//}

struct Day1Puzzle1: Solver {
  typealias Input = ([Int], [Int])
  typealias Output = Int

  func parse (_ input: String) -> Input {
    let numbers = input.matches(of: /([1-9]\d*)/).map { Int.init($0.1)! }
    let lists = numbers.enumerated().reduce(into: [[Int](), [Int]()]) { acc, el in
      acc[el.offset % 2].append(el.element)
    }

    return (lists[0], lists[1])
  }

  func solve (_ input: Input) -> Output {
    let (left, right) = input

    return zip(left.sorted(), right.sorted())
      .map(minus | abs)
      .sum()
  }
}
