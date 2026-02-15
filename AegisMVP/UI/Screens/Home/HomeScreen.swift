import SwiftUI

struct HomeScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AegisHeader(title: "Project Aegis", subtitle: "Offline-first survival MVP")

                NavigationLink(destination: LibraryCategoriesScreen()) {
                    HomeCard(title: "Survival Library", subtitle: "Offline articles by category", symbol: "books.vertical")
                }
                .buttonStyle(.plain)

                NavigationLink(destination: KnotViewerScreen()) {
                    HomeCard(title: "Knot Viewer", subtitle: "RealityKit 3D model", symbol: "cube.transparent")
                }
                .buttonStyle(.plain)

                NavigationLink(destination: MapScreen()) {
                    HomeCard(title: "Map", subtitle: "Scaffold with offline-ready architecture", symbol: "map")
                }
                .buttonStyle(.plain)

                NavigationLink(destination: SettingsScreen()) {
                    HomeCard(title: "Settings", subtitle: "Night vision + diagnostics", symbol: "gearshape")
                }
                .buttonStyle(.plain)
            }
            .padding()
        }
        .background(AegisTheme.background)
        .navigationTitle("Home")
    }
}

private struct HomeCard: View {
    let title: String
    let subtitle: String
    let symbol: String

    var body: some View {
        AegisCard {
            HStack(spacing: 12) {
                Image(systemName: symbol)
                    .font(.title2)
                    .foregroundStyle(AegisTheme.accent)
                    .frame(width: 60, height: 60)
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(AegisTheme.foreground)
                    Text(subtitle)
                        .font(.body)
                        .foregroundStyle(AegisTheme.secondaryText)
                }
                Spacer()
            }
            .frame(minHeight: 60)
        }
    }
}
