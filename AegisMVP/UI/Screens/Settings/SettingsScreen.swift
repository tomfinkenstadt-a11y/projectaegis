import SwiftUI

struct SettingsScreen: View {
    @EnvironmentObject private var appState: AppState
    @AppStorage("nightVisionEnabled") private var nightVisionEnabled = false

    var body: some View {
        List {
            Section("Display") {
                Toggle("Night Vision", isOn: $nightVisionEnabled)
                    .tint(AegisTheme.accent)
                    .font(.body)
                    .frame(minHeight: 60)
            }

            Section("Diagnostics") {
                DiagnosticsRow(label: "App version", value: appState.diagnostics.appVersion)
                DiagnosticsRow(label: "Build number", value: appState.diagnostics.buildNumber)
                DiagnosticsRow(label: "Database version", value: appState.diagnostics.databaseVersion)
                DiagnosticsRow(label: "Last DB init date", value: appState.diagnostics.dbInitDate)
                if let lastError = appState.diagnostics.lastError {
                    DiagnosticsRow(label: "Last error", value: lastError)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(AegisTheme.background)
        .navigationTitle("Settings")
    }
}

private struct DiagnosticsRow: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(AegisTheme.secondaryText)
            Text(value)
                .font(.body)
                .foregroundStyle(AegisTheme.foreground)
        }
        .frame(minHeight: 60, alignment: .leading)
    }
}
