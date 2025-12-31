📱 MVVMTeachingApp

A clean, scalable SwiftUI MVVM architecture demo app built for learning, teaching, and real-world iOS development.

This project focuses on:
	•	How MVVM actually works in practice
	•	Why MVVM is necessary for scalable apps
	•	How a proper folder structure keeps projects maintainable as they grow

⸻

🚀 Introduction

Modern iOS apps grow very quickly.
Without a strong architecture, projects become:
	•	Hard to maintain
	•	Hard to test
	•	Painful to scale

MVVM (Model–View–ViewModel) is one of the most effective architectures for SwiftUI apps.

This project demonstrates MVVM done the right way, using:
	•	SwiftUI
	•	Combine
	•	async/await
	•	Clean folder structure
	•	Clear separation of responsibilities

⚠️ The most important part of this project is its folder structure and responsibility separation.

⸻

🧠 What is MVVM?

MVVM stands for:

Layer	Description
Model	Data & business entities
View	UI only
ViewModel	Presentation logic & UI state

MVVM ensures:
	•	UI does not contain business logic
	•	Business logic does not depend on UI

⸻

❓ Why Do We Need MVVM?

❌ Problems Without MVVM

In many beginner projects:
	•	API calls are written inside Views
	•	Validation is handled inside Views
	•	Navigation logic is mixed with UI
	•	Multiple Bool flags control UI state

This leads to:
	•	Massive Views (500–1000 lines)
	•	Tight coupling between screens
	•	Difficult debugging
	•	No unit testing
	•	Poor scalability

This problem is known as the Massive View / ViewController problem.

⸻

✅ How MVVM Solves This

MVVM separates responsibilities clearly:

Responsibility	Where it goes
UI rendering	View
UI state	ViewModel
Business rules	UseCase
API calls	Repository
Validation	Core utilities
Navigation	Router

Result:
	•	Smaller files
	•	Cleaner logic
	•	Easier debugging
	•	Testable code
	•	Scalable architecture

⸻

🔄 How MVVM Works (Data Flow)

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

Key Rule:
Views never talk directly to APIs or databases.

⸻

🧩 How MVVM Is Implemented in This Project

🟦 View
	•	Displays UI
	•	Observes ViewModel
	•	Sends user actions to ViewModel

Example:

@StateObject private var viewModel = UserListViewModel()


⸻

🟩 ViewModel
	•	Holds UI state
	•	Calls UseCases
	•	Exposes @Published properties

Example:

@Published var users: [User]
@Published var state: ViewState

ViewModels import SwiftUI, not UIKit.

⸻

🟨 Model
	•	Pure data objects
	•	No UI or framework dependency

Example:

struct User {
    let id: Int
    let name: String
    let email: String
}


⸻

📂 MOST IMPORTANT: Folder Structure

⚠️ This project is designed around its folder structure. Do not move files randomly.

<pre><code>
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
</code></pre>



⸻

🌐 API & NETWORK LAYER — DETAILED EXPLANATION

📌 APIEndpoint.swift

Purpose:
Defines all API URLs in one place.

Why used:
	•	Avoids hardcoded URLs
	•	Easy to change environments
	•	Centralized API management

Example:

enum APIEndpoint {
    case users(page: Int)
}


⸻

📌 APIService.swift

Purpose:
Handles actual network calls using URLSession.

Why used:
	•	Single responsibility
	•	Reusable across app
	•	Easy to mock for testing

Example:

func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T


⸻

📌 UserRepository.swift

Purpose:
Acts as a bridge between APIService and UseCases.

Why used:
	•	ViewModels never call APIs directly
	•	API source can be replaced with DB or cache later
	•	Improves testability

⸻

🧠 USE CASES — WHY & HOW

📌 FetchUsersUseCase

Purpose:
Contains business logic for fetching users.

Why used:
	•	Keeps ViewModel clean
	•	One responsibility per use case
	•	Easy to test

⸻

📌 LoginUseCase

Purpose:
Encapsulates login validation logic.

Why used:
	•	Avoids logic in ViewModel
	•	Business rules stay in Domain layer

⸻

⚠️ Important Developer Rules

✅ Do This

Best Practice	Why It Matters
Follow folder structure	Maintains clean architecture
Keep Views simple	Prevents Massive View problems
Use ViewModels for logic	Clean separation
Use UseCases	Single responsibility
Use Repository	Decoupled data source
Use ViewState	Clean UI state handling


⸻

❌ Avoid This

Common Mistake	Why It’s Harmful
API calls inside Views	Tight coupling
Validation inside Views	Architecture violation
Multiple @main files	Build issues
Random folder placement	Hard to maintain
Tight View-to-View coupling	Poor scalability


⸻

🧪 Testing Benefits of MVVM

Benefit	Explanation
ViewModel testing	Logic tested without UI
UseCase testing	Business rules isolated
UI testing	UI only renders state


⸻

🚀 How This Helps in Real Projects

Advantage	Impact
Easier onboarding	Faster team understanding
Safer features	Fewer regressions
Cleaner Git history	Smaller commits
Interview readiness	Strong architecture signal
Scalability	App grows safely


⸻

🎓 Who Should Use This Project?

Audience	Reason
SwiftUI beginners	Learn MVVM correctly
iOS developers	Improve architecture
Interview candidates	Show best practices
Mentors	Teaching template
Production teams	Solid foundation


⸻

✅ Final Note

This project is not just about MVVM — it is about discipline.
Follow structure and responsibility separation, and your app will stay clean even at scale.
 