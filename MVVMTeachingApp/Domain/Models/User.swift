import Foundation

struct User: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let email: String
}
