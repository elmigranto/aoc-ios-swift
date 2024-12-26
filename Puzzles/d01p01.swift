fileprivate let plus: (Int, Int) -> Int = (+)
fileprivate let minus: (Int, Int) -> Int = (-)
fileprivate func unwrap<T> (_ value: T?) -> T { value! }


func minus<T: AdditiveArithmetic> (left: T, right: T) -> T {
  left - right
}

extension Puzzles {
  func d01p01 () -> String {
    let numbers = input.matches(of: /([1-9]\d*)/).map { Int.init($0.1)! }
    let lists = numbers.enumerated().reduce(into: [[Int](), [Int]()]) { acc, el in
      acc[el.offset % 2].append(el.element)
    }

    let distances = zip(lists[0].sorted(), lists[1].sorted()).map(minus | abs)

    return String(distances.sum())
  }
}
