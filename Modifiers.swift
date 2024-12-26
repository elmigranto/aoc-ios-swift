import SwiftUI

extension View {
  /// Add borders to SwiftUI's views.
  func debugLayout (_ color: Color = Color.red, print: Bool = false) -> some View {
    modifier(DebugLayout(color: color, print: print))
  }
}

fileprivate struct DebugLayout: ViewModifier {
  let color: Color
  let print: Bool

  private func printFunction (_ string: String) -> String {
    print ? pp(string) : string
  }

  func body (content: Content) -> some View {
    content
      .border(color)
      .overlay {
        GeometryReader { geom in
          // TODO: Text is barely visible.
          Text(printFunction(("\(geom.size.width.rounded().formatted())×\(geom.size.height.rounded().formatted())")))
            .padding()
            .foregroundStyle(.white)
            .background(color.opacity(0.5))
            .font(.footnote.monospaced())
            .allowsHitTesting(false)
        }
      }
  }
}
