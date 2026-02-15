import Foundation

final class DiagnosticsService: ObservableObject {
    @Published var appVersion: String = "Unknown"
    @Published var buildNumber: String = "Unknown"
    @Published var databaseVersion: String = "Unknown"
    @Published var dbInitDate: String = "Unknown"
    @Published var lastError: String?

    func refresh(dataStore: DataStore) {
        appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
        buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown"
        databaseVersion = dataStore.databaseVersion
        dbInitDate = dataStore.lastInitDate
    }
}
