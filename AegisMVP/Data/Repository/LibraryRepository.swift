import Foundation

final class LibraryRepository {
    private let database: SQLiteDatabase

    init(database: SQLiteDatabase) {
        self.database = database
    }

    func fetchCategories() throws -> [Category] {
        let rows = try database.query("SELECT id, name, sort_order FROM categories ORDER BY sort_order;")
        return rows.compactMap { row in
            guard let id = row["id"], let name = row["name"], let sort = Int(row["sort_order"] ?? "") else {
                return nil
            }
            return Category(id: id, name: name, sortOrder: sort)
        }
    }

    func fetchArticles(categoryId: String) throws -> [Article] {
        let rows = try database.query(
            "SELECT id, category_id, title, summary, body_markdown, sort_order FROM articles WHERE category_id = ? ORDER BY sort_order;",
            bind: [categoryId]
        )
        return rows.compactMap(Self.mapArticle)
    }

    func fetchArticleDetail(articleId: String) throws -> ArticleDetail? {
        guard let articleRow = try database.query(
            "SELECT id, category_id, title, summary, body_markdown, sort_order FROM articles WHERE id = ? LIMIT 1;",
            bind: [articleId]
        ).first,
        let article = Self.mapArticle(articleRow) else {
            return nil
        }

        let stepRows = try database.query(
            "SELECT id, article_id, step_number, step_text FROM article_steps WHERE article_id = ? ORDER BY step_number;",
            bind: [articleId]
        )
        let steps = stepRows.compactMap { row in
            guard let id = row["id"], let aid = row["article_id"], let no = Int(row["step_number"] ?? ""), let text = row["step_text"] else {
                return nil
            }
            return ArticleStep(id: id, articleID: aid, stepNumber: no, stepText: text)
        }

        return ArticleDetail(article: article, steps: steps)
    }

    private static func mapArticle(_ row: [String: String]) -> Article? {
        guard let id = row["id"], let categoryID = row["category_id"], let title = row["title"], let summary = row["summary"], let sort = Int(row["sort_order"] ?? "") else {
            return nil
        }
        let body = row["body_markdown"].flatMap { $0.isEmpty ? nil : $0 }
        return Article(id: id, categoryID: categoryID, title: title, summary: summary, bodyMarkdown: body, sortOrder: sort)
    }
}
