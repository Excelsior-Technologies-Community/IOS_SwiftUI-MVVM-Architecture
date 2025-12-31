import Foundation

enum APIEndpoint {
    case users(page: Int)

    var url: URL {
        switch self {
        case .users(let page):
            return URL(string: "https://jsonplaceholder.typicode.com/users?_page=\(page)")!
        }
    }
}
