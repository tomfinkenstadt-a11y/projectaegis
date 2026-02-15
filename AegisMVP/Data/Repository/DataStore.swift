import Foundation

final class DataStore {
    // TODO(Phase2): Migrate persisted SQLite file to SQLCipher-backed store.
    // TODO(Phase2): Move database root under secure region-pack storage boundaries.

    private(set) var dbPath: String = ""
    private(set) var database: SQLiteDatabase?
    private(set) var libraryRepository: LibraryRepository?
    private(set) var lastInitDate: String = "Unknown"
    let databaseVersion = "1"

    func initializeIfNeeded() throws {
        let fm = FileManager.default
        let appSupport = try fm.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let systemDir = appSupport.appendingPathComponent("Aegis/System", isDirectory: true)
        try fm.createDirectory(at: systemDir, withIntermediateDirectories: true)
        let destination = systemDir.appendingPathComponent("basic_survival.sqlite")

        if !fm.fileExists(atPath: destination.path) {
            guard let seed = Bundle.module.url(forResource: "seed", withExtension: "sql", subdirectory: "Seed") else {
                throw NSError(domain: "DataStore", code: 1, userInfo: [NSLocalizedDescriptionKey: "Missing seed.sql resource"])
            }
            let sql = try String(contentsOf: seed)
            let db = try SQLiteDatabase(path: destination.path)
            try db.execute(sql)
            let initDate = ISO8601DateFormatter().string(from: Date())
            try db.execute("INSERT OR REPLACE INTO meta (key, value) VALUES ('db_initialized_at', '\(initDate)');")
            lastInitDate = initDate
        }

        dbPath = destination.path
        database = try SQLiteDatabase(path: destination.path)
        libraryRepository = LibraryRepository(database: database!)

        if let row = try database?.query("SELECT value FROM meta WHERE key='db_initialized_at' LIMIT 1;").first,
           let value = row["value"], !value.isEmpty {
            lastInitDate = value
        }
    }
}
