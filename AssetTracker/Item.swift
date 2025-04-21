import Foundation

struct Item: Identifiable, Codable {
    var id = UUID()
    var name: String
    var price: Double
    var purchaseDate: Date

    var daysUsed: Int {
        Calendar.current.dateComponents([.day], from: purchaseDate, to: Date()).day ?? 0
    }

    var dailyCost: Double {
        daysUsed > 0 ? price / Double(daysUsed) : 0
    }
}
