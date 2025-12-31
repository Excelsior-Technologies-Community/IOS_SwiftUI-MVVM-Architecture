import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var isValid = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupValidation()
    }

    private func setupValidation() {
        Publishers.CombineLatest($email, $password)
            .sink { [weak self] email, password in
                self?.isValid =
                    Validator.isValidEmail(email) &&
                    Validator.isValidPassword(password)
            }
            .store(in: &cancellables)
    }
}
