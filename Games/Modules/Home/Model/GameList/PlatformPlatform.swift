import Foundation

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    let id: Int?
    let name, slug: String?
    let image, yearEnd: String?
    let yearStart: Int?
    let gamesCount: Int?
    let imageBackground: String?
}
