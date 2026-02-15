import SwiftUI

@main
struct AegisMVPApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(appState)
                .preferredColorScheme(.dark)
                .background(AegisTheme.background.ignoresSafeArea())
                .task {
                    await appState.bootstrap()
                }
        }
    }
}
