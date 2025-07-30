import Foundation
import SwiftUI

class TodoStore: ObservableObject {
    @Published var todos: [Todo] = []
    
    func addTodo(_ title: String) {
        let newTodo = Todo(title: title)
        todos.append(newTodo)
    }
    
    func removeTodo(at indexSet: IndexSet) {
        todos.remove(atOffsets: indexSet)
    }
    
    func toggleTodo(_ todo: Todo) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].toggle()
        }
    }
    
    func clearCompleted() {
        todos.removeAll { $0.isCompleted }
    }
    
    var completedCount: Int {
        todos.filter { $0.isCompleted }.count
    }
    
    var pendingCount: Int {
        todos.filter { !$0.isCompleted }.count
    }
}