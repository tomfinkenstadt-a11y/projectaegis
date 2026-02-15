import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack { HomeScreen() }
                .tabItem { Label("Home", systemImage: "house.fill") }

            NavigationStack { LibraryCategoriesScreen() }
                .tabItem { Label("Library", systemImage: "books.vertical.fill") }

            NavigationStack { MapScreen() }
                .tabItem { Label("Map", systemImage: "map.fill") }

            NavigationStack { SettingsScreen() }
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .tint(AegisTheme.accent)
    }
}
