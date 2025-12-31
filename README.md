📱 MVVMTeachingApp

A clean, scalable SwiftUI MVVM architecture demo app built for learning, teaching, and real-world iOS development.

This project focuses on how MVVM actually works in practice, why we need it, and how a proper folder structure keeps projects maintainable as they grow.

⸻

🚀 Introduction

Modern iOS apps grow very quickly.
Without a strong architecture, projects become hard to maintain, hard to test, and painful to scale.

MVVM (Model–View–ViewModel) is one of the most effective architectures for SwiftUI apps.
This project demonstrates MVVM done the right way, using:
    •    SwiftUI
    •    Combine
    •    async/await
    •    Clean folder structure
    •    Clear separation of responsibilities

⚠️ The most important part of this project is its folder structure and responsibility separation.

⸻

🧠 What is MVVM?

MVVM stands for:

Layer    Meaning
Model    Data & business entities
View    UI only
ViewModel    Presentation logic & state

MVVM ensures that UI does not contain business logic, and business logic does not depend on UI.

⸻

❓ Why Do We Need MVVM?

❌ Problems Without MVVM

In many beginner projects:
    •    API calls are written inside Views
    •    Validation is handled in Views
    •    Navigation logic is mixed with UI
    •    Multiple Bool flags control UI state

This leads to:
    •    ❌ Massive Views (500–1000 lines)
    •    ❌ Tight coupling between screens
    •    ❌ Difficult debugging
    •    ❌ No unit testing
    •    ❌ Poor scalability

This problem is known as the Massive View / ViewController problem.

⸻

✅ How MVVM Solves This

MVVM separates responsibilities clearly:

Responsibility    Where it goes
UI rendering    View
UI state    ViewModel
Business rules    UseCase
API calls    Repository
Validation    Core utilities
Navigation    Router

Result:
    •    ✔ Smaller files
    •    ✔ Cleaner logic
    •    ✔ Easier debugging
    •    ✔ Testable code
    •    ✔ Scalable architecture

⸻

🔄 How MVVM Works (Data Flow)

Typical MVVM Data Flow

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
View (Auto UI refresh)

Key Rule

Views never talk directly to APIs or databases.

⸻

🧩 How MVVM Is Implemented in This Project

🟦 View
    •    Displays UI
    •    Observes ViewModel
    •    Sends user actions to ViewModel

Example:

@StateObject private var viewModel = UserListViewModel()


⸻

🟩 ViewModel
    •    Holds UI state
    •    Calls UseCases
    •    Exposes @Published properties

Example:

@Published var users: [User]
@Published var state: ViewState

ViewModels import SwiftUI, not UIKit.

⸻

🟨 Model
    •    Pure data objects
    •    No UI or framework dependency

Example:

struct User {
    let id: Int
    let name: String
    let email: String
}


⸻

📂 MOST IMPORTANT: Folder Structure
<h2>📂 MOST IMPORTANT: Folder Structure</h2>

<p><strong>⚠️ This project is designed around its folder structure.</strong><br>
Do not move files randomly, as each folder represents a clear architectural responsibility.</p>

<pre><code>
MVVMTeachingApp
│
├── App
│   └── MVVMTeachingApp.swift          // App entry point (@main)
│
├── Core                               // Reusable utilities
│   ├── Navigation
│   │   └── AppRouter.swift
│   ├── State
│   │   └── ViewState.swift
│   └── Validation
│       └── Validator.swift
│
├── Domain                             // Business logic (UI independent)
│   ├── Models
│   │   └── User.swift
│   └── UseCases
│       ├── FetchUsersUseCase.swift
│       └── LoginUseCase.swift
│
├── Data                               // Data layer
│   ├── Network
│   │   ├── APIEndpoint.swift
│   │   └── APIService.swift
│   └── Repository
│       └── UserRepository.swift
│
├── Presentation                      // UI layer
│   ├── ViewModels
│   │   ├── LoginViewModel.swift
│   │   ├── UserListViewModel.swift
│   │   └── UserDetailViewModel.swift
│   └── Views
│       ├── LoginView.swift
│       ├── UserListView.swift
│       └── UserDetailView.swift
│
└── Assets.xcassets
</code></pre>
⸻

🧱 Layer Explanation (Why Each Exists)

🔹 App
    •    Entry point
    •    Sets root View
    •    Contains no logic

⸻

🔹 Core
    •    App-wide reusable logic
    •    No UI dependency
    •    Used across multiple features

⸻

🔹 Domain
    •    Business rules
    •    UseCases
    •    Independent of UI & networking

⸻

🔹 Data
    •    API calls
    •    Repositories
    •    Data source abstraction

⸻

🔹 Presentation
    •    Views (UI)
    •    ViewModels (state & logic)

⸻

⚠️ Important Developer Rules

✅ Do This

✔ Follow folder structure
✔ Keep Views simple
✔ Use ViewModels for logic
✔ Use UseCases for business rules
✔ Use Repository for data access
✔ Use ViewState for UI states

⸻

❌ Avoid This

❌ API calls inside Views
❌ Validation inside Views
❌ Multiple @main files
❌ Random folder placement
❌ Tight View-to-View coupling

⸻

🧪 Testing Benefits of MVVM

Because logic is separated:
    •    ViewModels can be unit tested
    •    UseCases can be tested independently
    •    UI tests become simpler

⸻

🚀 How This Helps in Real Projects
    •    Easier onboarding for new developers
    •    Safer feature additions
    •    Cleaner Git history
    •    Better interview readiness
    •    Production-grade scalability

⸻

🎓 Who Should Use This Project?
    •    Beginners learning SwiftUI
    •    Developers learning MVVM
    •    Interview preparation
    •    Teaching & mentoring
    •    Production app templates

⸻

✅ Final Note

This project is not just about MVVM — it is about discipline.
Follow the structure, and your app will stay clean even at scale.
