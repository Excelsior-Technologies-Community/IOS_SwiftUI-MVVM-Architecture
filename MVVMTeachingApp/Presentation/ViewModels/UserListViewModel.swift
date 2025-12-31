import SwiftUI
import Combine

@MainActor
final class UserListViewModel: ObservableObject {

    @Published var users: [User] = []
    @Published var state: ViewState = .idle
    @Published var route: AppRoute?

    private let fetchUsersUseCase = FetchUsersUseCase()
    private var page = 1

    func loadUsers() async {
        state = .loading
        do {
            users = try await fetchUsersUseCase.execute(page: page)
            state = .success
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func loadMore() async {
        page += 1
        let more = try? await fetchUsersUseCase.execute(page: page)
        users.append(contentsOf: more ?? [])
    }

    func selectUser(_ user: User) {
        route = .userDetail(user)
    }
}
