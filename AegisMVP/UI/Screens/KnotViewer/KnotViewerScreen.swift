import SwiftUI
import RealityKit

struct KnotViewerScreen: View {
    @State private var loadState: LoadState = .loading

    var body: some View {
        VStack(spacing: 16) {
            AegisHeader(title: "Knot Viewer", subtitle: "Inspect bundled 3D model")

            switch loadState {
            case .loading:
                ProgressView("Loading model...")
                    .tint(AegisTheme.accent)
                    .frame(maxWidth: .infinity, minHeight: 320)
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

            case .loaded(let entity):
                RealityView { content in
                    content.add(entity)
                }
                .frame(minHeight: 320)
                .background(Color.white.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 12))

            case .failed:
                AegisCard {
                    Text("Model unavailable")
                        .font(.headline)
                        .foregroundStyle(AegisTheme.foreground)
                }
            }

            Spacer()
        }
        .padding()
        .background(AegisTheme.background)
        .navigationTitle("Knot Viewer")
        .task {
            await loadModelIfNeeded()
        }
    }

    @MainActor
    private func loadModelIfNeeded() async {
        guard case .loading = loadState else { return }
        do {
            let entity = try await Entity(named: "sampleKnot", in: .module)
            loadState = .loaded(entity)
        } catch {
            loadState = .failed
        }
    }
}

private enum LoadState {
    case loading
    case loaded(Entity)
    case failed
}
