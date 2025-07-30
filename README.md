# iOS Todo App

A simple, elegant Todo application built with SwiftUI for iOS. This app provides a clean interface for managing your daily tasks without any database or local persistence - perfect for temporary task management.

## Features

- ✅ Add new todos with a clean, intuitive interface
- ✅ Mark todos as complete/incomplete with tap gesture
- ✅ Filter todos by All, Pending, or Completed
- ✅ Delete todos with swipe gesture
- ✅ Clear all completed todos at once
- ✅ View statistics (pending and completed count)
- ✅ Beautiful, modern SwiftUI design
- ✅ Smooth animations and transitions
- ✅ No persistence - data resets when app is closed

## Project Structure

```
TodoApp/
├── Sources/
│   └── TodoApp/
│       ├── TodoApp.swift         # Main app entry point
│       ├── Todo.swift            # Todo data model
│       ├── TodoStore.swift       # State management (ObservableObject)
│       ├── TodoListView.swift    # Main todo list view
│       ├── TodoRowView.swift     # Individual todo row component
│       └── AddTodoView.swift     # Add new todo view
└── Package.swift                 # Swift package configuration
```

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.9+

## Usage

1. Tap the "+" button to add a new todo
2. Tap the circle icon next to any todo to mark it as complete/incomplete
3. Swipe left on any todo to delete it
4. Use the segmented control to filter between All, Pending, and Completed todos
5. Tap "Clear Completed" to remove all completed todos at once

## Architecture

The app follows MVVM (Model-View-ViewModel) architecture:

- **Model**: `Todo` struct with id, title, and completion status
- **ViewModel**: `TodoStore` class using `ObservableObject` for state management
- **Views**: SwiftUI views for the user interface

## Key Components

### Todo Model
Simple struct with UUID, title, and completion status.

### TodoStore
ObservableObject that manages the array of todos and provides methods for:
- Adding new todos
- Toggling completion status
- Removing todos
- Clearing completed todos
- Computing statistics

### Views
- **TodoListView**: Main interface with list, filters, and statistics
- **TodoRowView**: Reusable component for displaying individual todos
- **AddTodoView**: Modal sheet for adding new todos

## No Persistence
This app intentionally does not include any form of data persistence (Core Data, UserDefaults, etc.). All todos are stored in memory and will be lost when the app is terminated. This makes it perfect for temporary task management or as a starting point for adding your preferred persistence layer.
