import SwiftUI

struct DatabaseView: View {
    @State private var resultText: String? = nil
    let numberOfUsers: Int

    var body: some View {
        NavigationView {
            VStack {
                if let text = resultText {
                    Text(text)
                        .multilineTextAlignment(.center)
                }
                Spacer()
                Button("Spremi i učitaj korisnike") {
                    saveAndLoadUsers()
                }
                .padding()
                Button("Prikaži broj korisnika") {
                    showUserCount()
                }
                .padding()
                Button("Očisti bazu podataka") {
                    clearDatabase()
                }
                .padding()
                Spacer()
            }
            .navigationBarTitle("SQLite baza podataka", displayMode: .inline)
        }
    }

    private func saveAndLoadUsers() {
        let startTime = Date()
        let database = Database.shared!

        for i in 0..<numberOfUsers {
            let user = User(id: nil, name: "User \(i)", age: i % 100)
            database.saveUser(user)
        }

        _ = database.getAllUsers()

        let endTime = Date()
        let duration = endTime.timeIntervalSince(startTime)
        resultText = "Uspješno spremljeno i učitano \(numberOfUsers) korisnika u vremenu: \(Int(duration * 1000))ms"
    }

    private func showUserCount() {
        let userCount = Database.shared!.countUsers()
        resultText = "Trenutni broj korisnika u bazi podataka: \(userCount)"
    }

    private func clearDatabase() {
        Database.shared!.clearDatabase()
        resultText = "Baza podataka je očišćena!"
    }
}
