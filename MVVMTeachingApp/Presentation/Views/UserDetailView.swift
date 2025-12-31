import SwiftUI

struct UserDetailView: View {

    @StateObject private var viewModel: UserDetailViewModel

    init(user: User) {
        _viewModel = StateObject(
            wrappedValue: UserDetailViewModel(user: user)
        )
    }

    var body: some View {
        VStack(spacing: 12) {
            Text(viewModel.user.name)
                .font(.largeTitle)

            Text(viewModel.user.email)
                .foregroundColor(.secondary)
        }
        .padding()
        .navigationTitle("User Detail")
    }
}
