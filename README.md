# 📱MVVMTeachingApp

A clean, scalable SwiftUI MVVM architecture demo app built for learning, teaching, and real-world iOS development.

---

## Index

1. [📖 Project Overview](#project-overview)
2. [🚀 Introduction](#introduction)
3. [🧠 What is MVVM?](#what-is-mvvm)
4. [❓ Why Do We Need MVVM?](#why-do-we-need-mvvm)
5. [✅ How MVVM Solves This](#how-mvvm-solves-this)
6. [🔄 MVVM Data Flow](#mvvm-data-flow)
7. [🧩 MVVM Implementation](#mvvm-implementation)
8. [📂 Folder Structure](#folder-structure)
9. [🧾 Code Explanation (File-by-File)](#code-explanation-file-by-file)
10. [⚠️ Important Developer Rules](#important-developer-rules)

---

## Project Overview

This project demonstrates how to implement **MVVM (Model–View–ViewModel)** correctly in a SwiftUI application. It focuses on:

- 🧠 How MVVM works in practice
- 📈 Why MVVM is necessary for scalable apps
- 🗂️ How proper folder structure improves maintainability
- 🔗 How to separate UI, business logic, and data layers

---

##🚀 Introduction

Modern iOS applications grow very quickly. Without a strong architecture, projects become difficult to maintain, test, and scale. **MVVM (Model–View–ViewModel)** is one of the most effective architectures for SwiftUI applications.

This project uses:

- 🧩 SwiftUI
- 🔄 Combine
- ⏳ async/await
- 📂 Clean folder structure
- 🧠 Clear separation of responsibilities

> The most important part of this project is its **folder structure and responsibility separation**.

---

## 🧠What is MVVM?

MVVM consists of three layers:

| Layer | Description |
| --- | --- |
| **Model** | Data and business entities |
| **View** | UI only |
| **ViewModel** | Presentation logic and UI state |

**MVVM ensures:**

* ✅UI does not contain business logic.
* ✅Business logic does not depend on UI.
* ✅Code is easier to test and maintain.

---

## Why Do We Need MVVM?

### ❌ Problems Without MVVM

In many beginner projects:

* API calls are written inside Views.
* Validation logic is placed in Views.
* Navigation logic is mixed with UI.
* Multiple Boolean flags control UI state.

**This leads to:**

* ❌**Massive Views** (500–1000 lines).
* ❌Tight coupling between screens.
* ❌Difficult debugging and no unit testing.
* ❌Poor scalability (the "Massive View/ViewController problem").

---

## ✅ How MVVM Solves This

MVVM separates responsibilities clearly:

| Responsibility | Layer |
| --- | --- |
| UI rendering | View |
| UI state | ViewModel |
| Business rules | UseCase |
| API calls | Repository |
| Validation | Core utilities |
| Navigation | Router |

---

## 🔄 MVVM Data Flow

1. **User Action** → View
2. **View** → ViewModel
3. **ViewModel** → UseCase
4. **UseCase** → Repository
5. **Repository** → API / Data Source
6. **Data flows back** → Repository → UseCase → ViewModel (`@Published` updates) → View (automatic UI refresh)

🔑 **Key rule:** Views never communicate directly with APIs or databases.

---

## 🧩 MVVM Implementation

### 🟦 View

* Display UI, observe ViewModel, and forward user actions.
* SwiftUI owns the ViewModel lifecycle using `@StateObject`.

```swift
@StateObject private var viewModel = UserListViewModel()

```

### 🟩  ViewModel

* Hold UI state and execute UseCases.
* Expose state using `@Published`.

```swift
@Published var users: [User]
@Published var state: ViewState

```

### 🟨  Model

* Represent data with no UI or framework dependency.

```swift
struct User {
    let id: Int
    let name: String
    let email: String
}

```

---

## 📂 Folder Structure

Maintain this hierarchy to ensure the project remains organized:

```text
MVVMTeachingApp
│
├── App
│   └── MVVMTeachingApp.swift
│
├── Core
│   ├── Navigation
│   │   └── AppRouter.swift
│   ├── State
│   │   └── ViewState.swift
│   └── Validation
│       └── Validator.swift
│
├── Domain
│   ├── Models
│   │   └── User.swift
│   └── UseCases
│       ├── FetchUsersUseCase.swift
│       └── LoginUseCase.swift
│
├── Data
│   ├── Network
│   │   ├── APIEndpoint.swift
│   │   └── APIService.swift
│   └── Repository
│       └── UserRepository.swift
│
├── Presentation
│   ├── ViewModels
│   └── Views
│
└── Assets.xcassets

```

---

## 🧾 Code Explanation (File-by-File)

### 1️⃣ 1. App Layer – `MVVMTeachingApp.swift`

Defines the application entry point and root view.

```swift
@main
struct MVVMTeachingApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView()
        }
    }
}

```

### 2️⃣ 2. Core Layer – `ViewState.swift`

Represents UI state in a structured way to avoid multiple Boolean flags.

```swift
enum ViewState {
    case idle
    case loading
    case success
    case error(String)
}

```

### 3️⃣ 3. Core Layer – `Validator.swift`

Centralizes validation logic.

```swift
enum Validator {
    static func isValidEmail(_ email: String) -> Bool {
        email.contains("@")
    }

    static func isValidPassword(_ password: String) -> Bool {
        password.count >= 6
    }
}

```

### 4️⃣ 4. Domain Layer – `User.swift`

Business model independent of UI.

```swift
struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let email: String
}

```

### 5️⃣ 5. Domain Layer – `FetchUsersUseCase.swift`

Encapsulates business logic for fetching users.

```swift
final class FetchUsersUseCase {
    private let repository = UserRepository()

    func execute(page: Int) async throws -> [User] {
        try await repository.fetchUsers(page: page)
    }
}

```

### 6️⃣ 6. Data Layer – `APIService.swift`

Handles network requests.

```swift
final class APIService {
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

```

### 7️⃣ 7. Presentation Layer – `UserListViewModel.swift`

Manages UI state and data loading.

```swift
@MainActor
final class UserListViewModel: ObservableObject {

    @Published var users: [User] = []
    @Published var state: ViewState = .idle

    private let fetchUsersUseCase = FetchUsersUseCase()

    func loadUsers() async {
        state = .loading
        do {
            users = try await fetchUsersUseCase.execute(page: 1)
            state = .success
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}

```

---

## Important Developer Rules

###✅  Do This

*📂 **Follow folder structure:** Maintains clean architecture.
*🎯 **Keep Views simple:** Avoids massive Views.
*🧠  **Use ViewModels for logic:** Separation of concerns.
*🧩  **Use UseCases:** Single responsibility.
*🔗 **Use Repositories:** Decoupled data access.

### Avoid This

* **API calls inside Views:** Leads to tight coupling.
* **Validation inside Views:** Architecture violation.
* **Multiple @main files:** Causes build issues.
* **Random folder placement:** Hard to maintain.

---

## Final Note

This project is not just about MVVM. It is about **discipline, structure, and responsibility separation**.
 