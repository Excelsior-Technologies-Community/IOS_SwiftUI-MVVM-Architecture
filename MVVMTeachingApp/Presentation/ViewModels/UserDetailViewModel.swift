import SwiftUI


// MARK: 3. User Detail ViewModel
@MainActor
final class UserDetailViewModel: ObservableObject {
    let user: User
    @Published var isFavorite = false
    
    init(user: User) {
        self.user = user
    }
    
    func toggleFavorite() {
        isFavorite.toggle()
    }
}
