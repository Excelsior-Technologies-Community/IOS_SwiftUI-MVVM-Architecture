
# MVVMTeachingApp

A clean, scalable SwiftUI MVVM architecture demo app built for learning, teaching, and real-world iOS development.

---

## Project Overview

This project focuses on:

- How MVVM actually works in practice
- Why MVVM is necessary for scalable apps
- How a proper folder structure keeps projects maintainable as they grow

---

## Introduction

Modern iOS applications grow very quickly.  
Without a strong architecture, projects become difficult to maintain, test, and scale.

MVVM (Model–View–ViewModel) is one of the most effective architectures for SwiftUI applications.

This project demonstrates MVVM implemented correctly using:

- SwiftUI
- Combine
- async/await
- Clean folder structure
- Clear separation of responsibilities

**Important:**  
The most critical part of this project is its folder structure and responsibility separation.

---

## What is MVVM?

MVVM stands for:

| Layer | Description |
|------|------------|
| Model | Data and business entities |
| View | UI only |
| ViewModel | Presentation logic and UI state |

MVVM ensures that:

- UI does not contain business logic
- Business logic does not depend on UI

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

This issue is commonly known as the **Massive View / ViewController problem**.

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

Example:

```swift
@StateObject private var viewModel = UserListViewModel()


⸻

ViewModel

Responsibilities:
	•	Hold UI state
	•	Execute UseCases
	•	Expose state using @Published

Example:

@Published var users: [User]
@Published var state: ViewState

ViewModels import SwiftUI, not UIKit.

⸻

Model

Responsibilities:
	•	Represent data
	•	Contain no UI or framework dependency

Example:

struct User {
    let id: Int
    let name: String
    let email: String
}


⸻

Folder Structure (Very Important)

This project is designed around its folder structure.
Do not move files randomly.

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

Important Developer Rules

Do This

Best Practice	Reason
Follow folder structure	Maintains clean architecture
Keep Views simple	Avoids massive Views
Use ViewModels for logic	Proper separation of concerns
Use UseCases	Single responsibility
Use Repositories	Decoupled data access
Use ViewState	Clean UI state handling


⸻

Avoid This

Mistake	Reason
API calls inside Views	Tight coupling
Validation inside Views	Architecture violation
Multiple @main files	Build issues
Random folder placement	Hard to maintain
View-to-View dependency	Poor scalability


⸻

Testing Benefits of MVVM

Area	Benefit
ViewModel	Test business logic without UI
UseCase	Isolated, testable logic
UI Tests	UI only renders state


⸻ 

## Code Explanation With Examples (File-by-File)

This section explains **what each file does**, **why it exists**, and **how the shown code fits into MVVM**.  
Each explanation includes **actual code snippets** so developers can clearly understand the purpose of the code.

---

## App Layer

### MVVMTeachingApp.swift

**Purpose:**  
Entry point of the application.

**Why this file exists:**  
Every SwiftUI app must have exactly one `@main` App file.  
This file defines which View is shown when the app launches.

**Code:**
```swift
@main
struct MVVMTeachingApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView()
        }
    }
}

Explanation:
	•	@main marks the app entry point
	•	WindowGroup hosts the root SwiftUI view
	•	No business logic should be written here

⸻

Core Layer

ViewState.swift

Purpose:
Represents the UI state in a structured way.

Why this file exists:
Instead of using multiple booleans like isLoading, hasError, etc.,
we use a single enum to describe UI state clearly.

Code:

enum ViewState {
    case idle
    case loading
    case success
    case error(String)
}

Explanation:
	•	ViewModels update ViewState
	•	Views react to state changes
	•	Makes UI logic predictable and readable

⸻

Validator.swift

Purpose:
Centralized validation logic.

Why this file exists:
Validation should not live in Views or ViewModels.
This keeps logic reusable and testable.

Code:

enum Validator {
    static func isValidEmail(_ email: String) -> Bool {
        email.contains("@")
    }

    static func isValidPassword(_ password: String) -> Bool {
        password.count >= 6
    }
}

Explanation:
	•	Static methods for easy reuse
	•	Keeps validation logic out of UI

⸻

Domain Layer

User.swift

Purpose:
Represents a business model.

Why this file exists:
Domain models must be independent of UI and frameworks.

Code:

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let email: String
}

Explanation:
	•	Used across API, Repository, ViewModel, and View
	•	Does not import SwiftUI

⸻

FetchUsersUseCase.swift

Purpose:
Encapsulates business logic for fetching users.

Why this file exists:
ViewModels should not contain business rules.

Code:

final class FetchUsersUseCase {
    private let repository = UserRepository()

    func execute(page: Int) async throws -> [User] {
        try await repository.fetchUsers(page: page)
    }
}

Explanation:
	•	ViewModel calls execute()
	•	Repository handles data source
	•	UseCase keeps logic focused and testable

⸻

Data Layer

APIEndpoint.swift

Purpose:
Defines all API endpoints in one place.

Why this file exists:
Avoids hardcoding URLs across the app.

Code:

enum APIEndpoint {
    case users(page: Int)

    var url: URL {
        switch self {
        case .users(let page):
            return URL(string: "https://example.com/users?page=\(page)")!
        }
    }
}

Explanation:
	•	Centralizes API configuration
	•	Easy to update endpoints later

⸻

APIService.swift

Purpose:
Handles network requests.

Why this file exists:
Keeps networking code separate from business logic.

Code:

final class APIService {
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

Explanation:
	•	Uses async/await
	•	Generic method for decoding any model
	•	Easy to mock in tests

⸻

UserRepository.swift

Purpose:
Acts as a bridge between APIService and UseCases.

Why this file exists:
Abstracts data source from business logic.

Code:

final class UserRepository {
    private let apiService = APIService()

    func fetchUsers(page: Int) async throws -> [User] {
        try await apiService.fetch([User].self,
                                   from: APIEndpoint.users(page: page).url)
    }
}

Explanation:
	•	ViewModels never call APIService directly
	•	Repository can be replaced with local DB later

⸻

Presentation Layer

UserListViewModel.swift

Purpose:
Manages user list state and data loading.

Why this file exists:
Separates UI from logic.

Code:

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

Explanation:
	•	Holds UI state
	•	Calls UseCases
	•	Publishes changes to View

⸻

UserListView.swift

Purpose:
Displays user list UI.

Why this file exists:
Views should only render data and handle user interaction.

Code:

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()

    var body: some View {
        List(viewModel.users) { user in
            Text(user.name)
        }
        .task {
            await viewModel.loadUsers()
        }
    }
}

Explanation:
	•	Observes ViewModel
	•	No business logic
	•	UI updates automatically on state change

⸻

Summary
	•	Every file has a single responsibility
	•	UI and logic are cleanly separated
	•	Code is testable and scalable
	•	Easy for new developers to understand

This structure demonstrates real-world MVVM, not just theory.

⸻


---

## ✅ HOW TO USE THIS SAFELY

1. Open `README.md`
2. Scroll to bottom
3. Paste this section
4. Commit and push

It will **render correctly on GitHub** and is **perfect for learning, interviews, and open-source**.

---
 
Real-World Benefits

Benefit	Impact
Easier onboarding	Faster understanding for new developers
Safer feature changes	Less regression risk
Cleaner Git history	Focused commits
Interview readiness	Demonstrates architecture skills
Scalability	App grows without architecture breakdown


⸻

Who Should Use This Project?

Audience	Purpose
SwiftUI beginners	Learn MVVM correctly
iOS developers	Improve architecture
Interview candidates	Showcase clean code
Mentors	Teaching reference
Production teams	Solid starter foundation


⸻

Final Note

This project is not just about MVVM.
It is about discipline, structure, and responsibility separation.
  