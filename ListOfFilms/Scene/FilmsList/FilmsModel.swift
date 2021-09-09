import Foundation

struct Films: Codable {
    var films: [Film]
}

struct Film: Codable {
    var id: Int
    var localized_name: String
    var name: String
    var year: Int
    var rating: Double?
    var image_url: String?
    var description: String?
    var genres: [String]
}
