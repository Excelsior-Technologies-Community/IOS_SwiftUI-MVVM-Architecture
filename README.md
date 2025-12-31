 
# MVVMTeachingApp

A clean, scalable SwiftUI MVVM architecture demo app built for learning, teaching, and real-world iOS development.

---

## Project Overview

This project demonstrates how to implement **MVVM (Model–View–ViewModel)** correctly in a SwiftUI application.

It focuses on:

- How MVVM works in practice
- Why MVVM is necessary for scalable apps
- How proper folder structure improves maintainability
- How to separate UI, business logic, and data layers

---

## Introduction

Modern iOS applications grow very quickly.  
Without a strong architecture, projects become difficult to maintain, test, and scale.

**MVVM (Model–View–ViewModel)** is one of the most effective architectures for SwiftUI applications.

This project uses:

- SwiftUI
- Combine
- async/await
- Clean folder structure
- Clear separation of responsibilities

> The most important part of this project is its **folder structure and responsibility separation**.

---

## What is MVVM?

MVVM consists of three layers:

| Layer | Description |
|------|------------|
| Model | Data and business entities |
| View | UI only |
| ViewModel | Presentation logic and UI state |

MVVM ensures:

- UI does not contain business logic
- Business logic does not depend on UI
- Code is easier to test and maintain

---

## Why Do We Need MVVM?

### Problems Without MVVM

In many beginner projects:

- API calls are written inside Views
- Validation logic is placed in Views
- Navigation logic is mixed with UI
- Multiple Boolean flags control UI state

This leads to:

- Massive Views (500–1000 lines)
- Tight coupling between screens
- Difficult debugging
- No unit testing
- Poor scalability

This is known as the **Massive View / ViewController problem**.

---

## How MVVM Solves This

MVVM separates responsibilities clearly:

| Responsibility | Layer |
|---------------|-------|
| UI rendering | View |
| UI state | ViewModel |
| Business rules | UseCase |
| API calls | Repository |
| Validation | Core utilities |
| Navigation | Router |

Benefits:

- Smaller files
- Cleaner logic
- Easier debugging
- Testable code
- Scalable architecture

---

## MVVM Data Flow

User Action
↓
View
↓
ViewModel
↓
UseCase
↓
Repository
↓
API / Data Source
↓
Repository
↓
UseCase
↓
ViewModel (@Published updates)
↓
View (automatic UI refresh)

**Key rule:**  
Views never communicate directly with APIs or databases.

---

## MVVM Implementation in This Project

### View

Responsibilities:

- Display UI
- Observe ViewModel
- Forward user actions to ViewModel

SwiftUI owns the ViewModel lifecycle using `@StateObject`.

```swift
@StateObject private var viewModel = UserListViewModel()


⸻

ViewModel

Responsibilities:
	•	Hold UI state
	•	Execute UseCases
	•	Expose state using @Published

@Published var users: [User]
@Published var state: ViewState

ViewModels import SwiftUI, not UIKit.

⸻

Model

Responsibilities:
	•	Represent data
	•	Contain no UI or framework dependency

struct User {
    let id: Int
    let name: String
    let email: String
}


⸻

Folder Structure (Very Important)

Do not move files randomly.
Each folder has a clear responsibility.

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


⸻

Code Explanation (File-by-File)

App Layer – MVVMTeachingApp.swift

Purpose:
Defines the application entry point and root view.

@main
struct MVVMTeachingApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView()
        }
    }
}


⸻

Core Layer – ViewState.swift

Purpose:
Represents UI state in a structured way.

enum ViewState {
    case idle
    case loading
    case success
    case error(String)
}

Why used:
	•	Avoids multiple Boolean flags
	•	Makes UI state predictable

⸻

Core Layer – Validator.swift

Purpose:
Centralizes validation logic.

enum Validator {
    static func isValidEmail(_ email: String) -> Bool {
        email.contains("@")
    }

    static func isValidPassword(_ password: String) -> Bool {
        password.count >= 6
    }
}


⸻

Domain Layer – User.swift

Purpose:
Business model independent of UI.

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let email: String
}


⸻

Domain Layer – FetchUsersUseCase.swift

Purpose:
Encapsulates business logic for fetching users.

final class FetchUsersUseCase {
    private let repository = UserRepository()

    func execute(page: Int) async throws -> [User] {
        try await repository.fetchUsers(page: page)
    }
}


⸻

Data Layer – APIService.swift

Purpose:
Handles network requests.

final class APIService {
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}


⸻

Presentation Layer – UserListViewModel.swift

Purpose:
Manages UI state and data loading.

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


⸻

Important Developer Rules

Do This

Rule	Reason
Follow folder structure	Maintains clean architecture
Keep Views simple	Avoids massive Views
Use ViewModels for logic	Separation of concerns
Use UseCases	Single responsibility
Use Repositories	Decoupled data access


⸻

Avoid This

Mistake	Reason
API calls inside Views	Tight coupling
Validation inside Views	Architecture violation
Multiple @main files	Build issues
Random folder placement	Hard to maintain


⸻

Final Note

This project is not just about MVVM.
It is about discipline, structure, and responsibility separation.
 