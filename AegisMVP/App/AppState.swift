import Foundation

@MainActor
final class AppState: ObservableObject {
    // TODO(Phase2): Add receipt validation service boundaries.
    // TODO(Phase2): Add App Attest / jailbreak heuristic hooks.
    @Published var dataStore = DataStore()
    @Published var diagnostics = DiagnosticsService()

    func bootstrap() async {
        do {
            try dataStore.initializeIfNeeded()
            diagnostics.refresh(dataStore: dataStore)
        } catch {
            diagnostics.lastError = error.localizedDescription
        }
    }
}
