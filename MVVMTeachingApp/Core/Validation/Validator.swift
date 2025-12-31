import Foundation

enum Validator {

    static func isValidEmail(_ email: String) -> Bool {
        email.contains("@") && email.contains(".")
    }

    static func isValidPassword(_ password: String) -> Bool {
        password.count >= 6
    }
}
