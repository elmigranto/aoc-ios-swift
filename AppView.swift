import SwiftUI

enum Puzzle: CaseIterable {
  case d01p1
}

struct ContentView: View {
  @State private var answers = [Puzzle: String]()

  var body: some View {
    ForEach(Puzzle.allCases, id: \.self) { id in
      GroupBox {
        VStack(alignment: .leading) {
          let idString = String(describing: id)
          let url = Bundle.main.url(forResource: idString, withExtension: "txt")!
          let input = try! String(contentsOf: url, encoding: .utf8)
          let answer = answers[id]

          HStack(alignment: .top) {
            VStack(alignment: .leading) {
              Text(idString).font(.body.bold())
              Text(answer ?? "No answer")
            }

            Spacer()
            Button("Calculate", systemImage: "arrow.clockwise") {
              // TODO: Non-main thread
              answers[id] = Puzzles(input).d01p01()
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
