import Foundation

// MARK: - Result
struct Game: Codable {
    var id: Int64?
    var name: String?
    var background_image: String?
    var metacritic: Int16?
    var rating: Double?
    var rating_top: Int?
    var ratings: [Rating]?
    var genres: [Genre]?
    // this is for local handling only
    var isFavorite: Bool?
    var isOpened: Bool?
    
    init() {}
}
