import SwiftUI

struct ArticleDetailScreen: View {
    let articleID: String

    @EnvironmentObject private var appState: AppState
    @State private var detail: ArticleDetail?
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let detail {
                    AegisHeader(title: detail.article.title, subtitle: detail.article.summary)

                    ForEach(detail.steps) { step in
                        AegisCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Step \(step.stepNumber)")
                                    .font(.headline)
                                    .foregroundStyle(AegisTheme.accent)
                                Text(step.stepText)
                                    .font(.body)
                                    .foregroundStyle(AegisTheme.foreground)
                            }
                        }
                    }
                } else if let errorMessage {
                    AegisCard {
                        Text(errorMessage)
                            .font(.body)
                            .foregroundStyle(.red)
                    }
                } else {
                    ProgressView("Loading article...")
                        .tint(AegisTheme.accent)
                        .font(.body)
                }
            }
            .padding()
        }
        .background(AegisTheme.background)
        .navigationTitle("Article")
        .task { load() }
    }

    private func load() {
        guard let repo = appState.dataStore.libraryRepository else { return }
        do {
            detail = try repo.fetchArticleDetail(articleId: articleID)
            if detail == nil {
                errorMessage = "Article unavailable."
            } else {
                errorMessage = nil
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
