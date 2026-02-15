import Foundation
import SQLite3

private let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

final class SQLiteDatabase {
    private var handle: OpaquePointer?

    init(path: String) throws {
        if sqlite3_open(path, &handle) != SQLITE_OK {
            throw SQLiteError.openFailed(path)
        }
    }

    deinit { sqlite3_close(handle) }

    func execute(_ sql: String) throws {
        if sqlite3_exec(handle, sql, nil, nil, nil) != SQLITE_OK {
            throw SQLiteError.message(lastError())
        }
    }

    func query(_ sql: String, bind: [String] = []) throws -> [[String: String]] {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(handle, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.message(lastError())
        }
        defer { sqlite3_finalize(statement) }

        for (idx, value) in bind.enumerated() {
            sqlite3_bind_text(statement, Int32(idx + 1), value, -1, SQLITE_TRANSIENT)
        }

        var rows: [[String: String]] = []
        while sqlite3_step(statement) == SQLITE_ROW {
            var row: [String: String] = [:]
            let count = sqlite3_column_count(statement)
            for i in 0..<count {
                guard let namePtr = sqlite3_column_name(statement, i) else { continue }
                let key = String(cString: namePtr)
                if let text = sqlite3_column_text(statement, i) {
                    row[key] = String(cString: text)
                } else {
                    row[key] = ""
                }
            }
            rows.append(row)
        }
        return rows
    }

    private func lastError() -> String {
        guard let c = sqlite3_errmsg(handle) else { return "Unknown sqlite error" }
        return String(cString: c)
    }
}

enum SQLiteError: Error {
    case openFailed(String)
    case message(String)
}
