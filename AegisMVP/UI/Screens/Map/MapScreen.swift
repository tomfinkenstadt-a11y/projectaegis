import SwiftUI

struct MapScreen: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AegisHeader(title: "Map", subtitle: "Offline pack architecture scaffold")

            if MapConfiguration.isConfigured {
                MapConfiguredView()
            } else {
                AegisCard {
                    Text("Map module online/offline packs coming in Phase 2. Add MAPBOX_ACCESS_TOKEN in Secrets.xcconfig to enable provider integration.")
                        .font(.body)
                        .foregroundStyle(AegisTheme.secondaryText)
                }
            }

            Spacer()
        }
        .padding()
        .background(AegisTheme.background)
        .navigationTitle("Map")
    }
}

private enum MapConfiguration {
    static var isConfigured: Bool {
        let infoToken = Bundle.main.object(forInfoDictionaryKey: "MAPBOX_ACCESS_TOKEN") as? String
        let envToken = ProcessInfo.processInfo.environment["MAPBOX_ACCESS_TOKEN"]
        let token = (infoToken ?? envToken ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        return !token.isEmpty && token != "<INSERT>"
    }
}

private struct MapConfiguredView: View {
    var body: some View {
        #if canImport(MapboxMaps)
        Text("Mapbox dependency detected. Integrate map view here.")
            .foregroundStyle(AegisTheme.foreground)
            .frame(maxWidth: .infinity, minHeight: 220)
            .background(Color.white.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        #else
        AegisCard {
            Text("Mapbox token detected, but MapboxMaps SDK is not linked in this build. Placeholder active.")
                .font(.body)
                .foregroundStyle(AegisTheme.secondaryText)
        }
        #endif
    }
}
