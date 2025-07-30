import SwiftUI

struct TodoRowView: View {
    let todo: Todo
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(todo.isCompleted ? .green : .gray)
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle())
            
            Text(todo.title)
                .strikethrough(todo.isCompleted)
                .foregroundColor(todo.isCompleted ? .gray : .primary)
                .font(.body)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    VStack {
        TodoRowView(todo: Todo(title: "Sample Todo"), onToggle: {})
        TodoRowView(todo: Todo(title: "Completed Todo").applying { $0.isCompleted = true }, onToggle: {})
    }
    .padding()
}

extension Todo {
    func applying(_ transform: (inout Todo) -> Void) -> Todo {
        var copy = self
        transform(&copy)
        return copy
    }
}