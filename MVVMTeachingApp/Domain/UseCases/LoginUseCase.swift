import Foundation

final class LoginUseCase {

    func execute(email: String, password: String) -> Bool {
        Validator.isValidEmail(email) && Validator.isValidPassword(password)
    }
}
