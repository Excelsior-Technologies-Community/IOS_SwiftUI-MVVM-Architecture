import SwiftUI

struct UserListView: View {

    @StateObject private var viewModel = UserListViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Users")
                .task {
                    await viewModel.loadUsers()
                }
                .navigationDestination(item: $viewModel.route) { route in
                    switch route {
                    case .userDetail(let user):
                        UserDetailView(user: user)
                    }
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()

        case .success:
            List(viewModel.users) { user in
                Button {
                    viewModel.selectUser(user)
                } label: {
                    VStack(alignment: .leading) {
                        Text(user.name)
                        Text(user.email)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }

        case .error(let message):
            Text(message)
                .foregroundColor(.red)
        }
    }
}
