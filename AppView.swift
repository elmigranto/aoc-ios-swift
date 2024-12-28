import SwiftUI

fileprivate let days: [any Solver.Type] = [
  Day01.self,
  Day02.self,
]

fileprivate let aoc2024 = days.reduce(into: [String: any Solver.Type]()) { acc, el in
  let key = String(describing: el)
  let value = el

  acc[key] = value
}

struct ContentView: View {
  @State private var answersPartOne = [String: String]()
  @State private var answersPartTwo = [String: String]()

  var body: some View {
    let keys: [String] = Array(aoc2024.keys).sorted()

    ForEach(keys, id: \.self) { puzzleId in
      GroupBox {
        VStack(alignment: .leading) {
          let Solver = aoc2024[puzzleId]!
          let input = Bundle.main.readPuzzleInput(Solver)

          HStack(alignment: .top) {
            VStack(alignment: .leading) {
              Text(puzzleId).font(.body.bold())

              MaybeAnswer(title: "Part one", answer: answersPartOne[puzzleId])
              MaybeAnswer(title: "Part two", answer: answersPartTwo[puzzleId])
            }

            Spacer()

            // TODO: Move outside of main thread.
            Button("Calculate", systemImage: "arrow.clockwise") {
              let solver = Solver.init()

              // TODO: Parses twice due to `any Solver`.
              answersPartOne[puzzleId] = solver.solvePartOne(input)
              answersPartTwo[puzzleId] = solver.solvePartTwo(input)
            }
            .labelStyle(.iconOnly)
          }

          ScrollView(.vertical) {
            Text(input)
              .font(.caption.monospaced())
          }
          .frame(height: 100)
        }
      }
    }
    .safeAreaPadding()
  }
}

struct MaybeAnswer: View {
  let title: String
  let answer: String?

  var body: some View {
    HStack {
      Text("\(title):")

      if let answer {
        Text(answer)
          .font(.body.monospaced())
          .textSelection(.enabled)
      }
      else {
        Text("No answer")
      }
    }
  }
}

#Preview {
  ContentView()
}
