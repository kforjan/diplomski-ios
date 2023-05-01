import GRDB
import Foundation

struct User: Codable, FetchableRecord, MutablePersistableRecord {
    var id: Int64?
    var name: String
    var age: Int
    
    static let databaseTableName = "users"
}

class Database {
    static let shared = Database()
    private let dbQueue: DatabaseQueue

    private init?() {
        let fileManager = FileManager.default
        let documentsPath = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let dbUrl = documentsPath?.appendingPathComponent("db.sqlite")

        guard let url = dbUrl, let queue = try? DatabaseQueue(path: url.path) else {
            return nil
        }

        dbQueue = queue
        setupDatabase()
    }

    private func setupDatabase() {
        try? dbQueue.write { db in
            try db.create(table: User.databaseTableName, ifNotExists: true) { table in // Ovdje
                table.autoIncrementedPrimaryKey("id")
                table.column("name", .text).notNull()
                table.column("age", .integer).notNull()
            }
        }
    }


    func saveUser(_ user: User) {
        try? dbQueue.write { db in
            var newUser = user
            newUser.id = nil
            try newUser.insert(db)
        }
    }

    func getAllUsers() -> [User] {
        return try! dbQueue.read { db in
            return try User.fetchAll(db)
        }
    }

    func clearDatabase() {
        if let _ = try? dbQueue.write({ db in
            try User.deleteAll(db)
        }) {
        } else {
        }
    }

    func countUsers() -> Int {
        return try! dbQueue.read { db in
            return try User.fetchCount(db)
        }
    }
}
