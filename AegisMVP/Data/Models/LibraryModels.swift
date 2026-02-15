import Foundation

struct Category: Identifiable {
    let id: String
    let name: String
    let sortOrder: Int
}

struct Article: Identifiable {
    let id: String
    let categoryID: String
    let title: String
    let summary: String
    let bodyMarkdown: String?
    let sortOrder: Int
}

struct ArticleStep: Identifiable {
    let id: String
    let articleID: String
    let stepNumber: Int
    let stepText: String
}

struct ArticleDetail {
    let article: Article
    let steps: [ArticleStep]
}
