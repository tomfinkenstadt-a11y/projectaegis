import SwiftUI

struct LibraryArticlesScreen: View {
    let category: Category

    @EnvironmentObject private var appState: AppState
    @State private var articles: [Article] = []
    @State private var errorMessage: String?
    @State private var isLoading = false

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Loading articles...")
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

                    if articles.isEmpty && errorMessage == nil {
                        Text("No articles found for this category.")
                            .foregroundStyle(AegisTheme.secondaryText)
                            .font(.body)
                            .frame(minHeight: 60, alignment: .leading)
                    }

                    ForEach(articles) { article in
                        NavigationLink(destination: ArticleDetailScreen(articleID: article.id)) {
                            AegisListRow(title: article.title, subtitle: article.summary)
                        }
                        .listRowBackground(AegisTheme.background)
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .background(AegisTheme.background)
        .navigationTitle(category.name)
        .task { load() }
    }

    private func load() {
        guard let repo = appState.dataStore.libraryRepository else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            articles = try repo.fetchArticles(categoryId: category.id)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
