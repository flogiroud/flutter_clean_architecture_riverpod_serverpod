# Nexo: A Flutter Clean Architecture example
### Riverpod + Serverpod (2023 versions)

## Overview
Nexo is a project designed to demonstrate the application of **Clean Architecture** in Flutter (with Riverpod for state management), Serverpod for backend, and a dedicated client structure. This is **not a fully functional application**, but rather an **example of well-structured patterns** demonstrated through these frameworks and tools.

## Project Structure
The project is divided into three main parts:
- **nexo_flutter**: The Flutter frontend application.
- **nexo_server**: The backend using Serverpod.
- **nexo_client**: The client implementation.

### Flutter Structure
The **nexo_flutter** project follows Clean Architecture principles and is structured as follows:
```
├── main.dart
└── src
    ├── config           # App-wide configurations (routing, theme, session management, etc.)
    ├── data             # Data layer (repositories, models, API implementations)
    ├── domain           # Business logic (use cases, entities, interfaces for repositories)
    ├── presentation     # UI layer (features, state management, views, widgets, localization)
    ├── utils            # Utility classes and error handling
```

### Client Structure
The **nexo_client** folder is structured as follows:
```
├── nexo_client.dart
└── src
    ├── custom_exception.dart     # Custom exception handling
    └── protocol
        ├── client.dart           # Client-side protocol handling
        ├── example.dart          # Example protocol usage
        ├── nexo_user_info.dart   # Nexo user-related data handling
        └── protocol.dart         # General protocol definitions
```
### Server Structure
The **nexo_server** folder is structured as follows:
```
├── server.dart
└── src
    ├── endpoints
    │   └── user_endpoint.dart            # Endpoint to manage user-related requests
    ├── future_calls
    │   └── example_future_call.dart      # Example of asynchronous server-side logic
    ├── generated
    │   ├── endpoints.dart                # Generated endpoint definitions
    │   ├── example.dart                  # Generated example data handling
    │   ├── nexo_user_info.dart           # User data model for the server
    │   └── protocol.dart                 # General protocol definitions
    ├── protocol
    │   ├── example.yaml                  # Example protocol configuration
    │   └── nexo_user_info.yaml           # User data protocol configuration
    ├── utils
    │   ├── server_exception_type.dart    # Server-side exception types
    │   └── server_exception_type.g.dart  # Generated code for exception handling
    └── web
        ├── routes
        │   └── root.dart                 # Root route for the server
        └── widgets
            └── default_page_widget.dart  # Default page layout for the server
```
## Tech Stack
- **Flutter** with **Riverpod** for state management
- **Serverpod** for backend development
- **Dart** for both frontend and backend
- **Clean Architecture** to maintain separation of concerns

## Why This Project?
This repository provides a reference for implementing **scalable and maintainable architectures** in Flutter applications. By following Clean Architecture principles, one can achieve:
- **Better testability**
- **Improved scalability**
- **Easier maintenance**
- **Separation of concerns**
