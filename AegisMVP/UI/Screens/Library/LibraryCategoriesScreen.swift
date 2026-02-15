import SwiftUI

struct LibraryCategoriesScreen: View {
    @EnvironmentObject private var appState: AppState
    @State private var categories: [Category] = []
    @State private var errorMessage: String?
    @State private var isLoading = false

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Loading categories...")
                    .tint(AegisTheme.accent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    if let errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .font(.body)
                            .frame(minHeight: 60, alignment: .leading)
                    }

                    if categories.isEmpty && errorMessage == nil {
                        Text("No categories available.")
                            .foregroundStyle(AegisTheme.secondaryText)
                            .font(.body)
                            .frame(minHeight: 60, alignment: .leading)
                    }

                    ForEach(categories) { category in
                        NavigationLink(destination: LibraryArticlesScreen(category: category)) {
                            AegisListRow(title: category.name, subtitle: "Category")
                        }
                        .listRowBackground(AegisTheme.background)
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .background(AegisTheme.background)
        .navigationTitle("Survival Library")
        .task { load() }
    }

    private func load() {
        guard let repo = appState.dataStore.libraryRepository else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            categories = try repo.fetchCategories()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
