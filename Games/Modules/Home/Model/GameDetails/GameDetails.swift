import Foundation

// MARK: - Welcome
struct GameDetails: Codable {
    var id: Int64?
    var slug, name, name_original, description: String?
    var metacritic: Int16?
    var released: String?
    var tba: Bool?
    var updated: String?
    var background_image, background_image_additional: String?
    var website: String?
    var rating: Double?
    var rating_top: Int?
    var ratings: [Rating?]?
    var added: Int?
    var added_by_status: AddedByStatus?
    var playtime, screenshots_count, movies_count, creators_count: Int?
    var achievements_count, parent_achievements_count: Int?
    var reddit_url: String?
    var reddit_name, reddit_description, reddit_logo: String?
    var reddit_count, twitch_count, youtube_count, reviews_text_count: Int?
    var ratings_count, suggestions_count: Int?
    var metacritic_url: String?
    var parents_count, additions_count, gameSeries_count: Int?
    var reviews_count: Int?
    var saturated_color, dominant_color: String?
    var platforms: [PlatformElement]?
    var genres, developers: [Genre?]?
    var stores, tags, publishers: [Store?]?
    var esrb_rating: AddedByStatus?
    var clip: String?
    var description_raw: String?
    // this is for local handling only
    var isFavorite: Bool?
    
    init() {}
}
