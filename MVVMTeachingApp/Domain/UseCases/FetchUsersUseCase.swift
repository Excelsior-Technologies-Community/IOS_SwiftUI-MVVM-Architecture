import Foundation

final class FetchUsersUseCase {

    private let repository = UserRepository()

    func execute(page: Int) async throws -> [User] {
        try await repository.fetchUsers(page: page)
    }
}
