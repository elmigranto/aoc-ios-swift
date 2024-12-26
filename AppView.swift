import SwiftUI

fileprivate let aoc2024: [String: any Solver.Type] = [
  "d01p1": Day1Puzzle1.self
]

struct ContentView: View {
  @State private var answers = [String: String]()

  var body: some View {
    let keys: [String] = Array(aoc2024.keys).sorted()

    ForEach(keys, id: \.self) { puzzleId in
      GroupBox {
        VStack(alignment: .leading) {
          let url = Bundle.main.url(forResource: puzzleId, withExtension: "txt")!
          let input = try! String(contentsOf: url, encoding: .utf8)
          let answer = answers[puzzleId]

          HStack(alignment: .top) {
            VStack(alignment: .leading) {
              Text(puzzleId).font(.body.bold())
              Text(answer ?? "No answer")
            }

            Spacer()

            Button("Calculate", systemImage: "arrow.clockwise") {
              // TODO: Non-main thread
              let Solver = aoc2024[puzzleId]!
              let solver = Solver.init()
              let answer: String = solver.solve(input)

              answers[puzzleId] = answer
            }
            .labelStyle(.iconOnly)
          }

          ScrollView(.vertical) {
            Text(input)
              .font(.caption.monospaced())
          }
          .frame(height: 200)
        }
      }
    }
    .safeAreaPadding()
  }
}

#Preview {
  ContentView()
}
