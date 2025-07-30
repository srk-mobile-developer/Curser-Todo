import SwiftUI

struct TodoListView: View {
    @StateObject private var todoStore = TodoStore()
    @State private var showingAddTodo = false
    @State private var filterType: FilterType = .all
    
    enum FilterType: String, CaseIterable {
        case all = "All"
        case pending = "Pending"
        case completed = "Completed"
    }
    
    var filteredTodos: [Todo] {
        switch filterType {
        case .all:
            return todoStore.todos
        case .pending:
            return todoStore.todos.filter { !$0.isCompleted }
        case .completed:
            return todoStore.todos.filter { $0.isCompleted }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Header with stats
                if !todoStore.todos.isEmpty {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(todoStore.pendingCount) pending")
                                .font(.caption)
                                .foregroundColor(.orange)
                            Text("\(todoStore.completedCount) completed")
                                .font(.caption)
                                .foregroundColor(.green)
                        }
                        
                        Spacer()
                        
                        if todoStore.completedCount > 0 {
                            Button("Clear Completed") {
                                withAnimation {
                                    todoStore.clearCompleted()
                                }
                            }
                            .foregroundColor(.red)
                            .font(.caption)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                
                // Filter picker
                if !todoStore.todos.isEmpty {
                    Picker("Filter", selection: $filterType) {
                        ForEach(FilterType.allCases, id: \.self) { filter in
                            Text(filter.rawValue).tag(filter)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                }
                
                // Todo list
                if filteredTodos.isEmpty {
                    Spacer()
                    VStack(spacing: 16) {
                        Image(systemName: filterType == .all ? "checklist" : "checkmark.circle")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        
                        Text(emptyStateMessage)
                            .font(.title3)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                } else {
                    List {
                        ForEach(filteredTodos) { todo in
                            TodoRowView(todo: todo) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    todoStore.toggleTodo(todo)
                                }
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                        .onDelete { indexSet in
                            withAnimation {
                                let todosToDelete = indexSet.map { filteredTodos[$0] }
                                for todo in todosToDelete {
                                    if let index = todoStore.todos.firstIndex(where: { $0.id == todo.id }) {
                                        todoStore.todos.remove(at: index)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("My Todos")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddTodo = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddTodo) {
            AddTodoView(
                onAdd: { title in
                    withAnimation {
                        todoStore.addTodo(title)
                    }
                    showingAddTodo = false
                },
                onCancel: {
                    showingAddTodo = false
                }
            )
        }
    }
    
    private var emptyStateMessage: String {
        switch filterType {
        case .all:
            return "No todos yet!\nTap the + button to add your first todo."
        case .pending:
            return "No pending todos!\nAll tasks are completed."
        case .completed:
            return "No completed todos yet!\nComplete some tasks to see them here."
        }
    }
}

#Preview {
    TodoListView()
}