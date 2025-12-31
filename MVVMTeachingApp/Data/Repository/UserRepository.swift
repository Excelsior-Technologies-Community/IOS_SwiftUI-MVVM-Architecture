import Foundation

final class UserRepository {

    private let apiService = APIService()

    func fetchUsers(page: Int) async throws -> [User] {
        try await apiService.fetch([User].self, from: APIEndpoint.users(page: page).url)
    }
}
