import Foundation

// MARK: - Genre
struct Genre: Codable {
    var Idd: Int?
    var name: String?
    var slug: String?
    var games_count: Int?
    var image_background: String?
    var domain: String?
    var language: String?
    
    init() {}
    
    init(name: String) {
        self.name = name
    }
}
