import Foundation

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int?
    let dropped, playing: Int?
}
