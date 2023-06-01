import Foundation

// MARK: - Welcome
struct GameList: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Game]?
    var description: String?
    
    init() {}
}
