import SwiftUI

struct AddTodoView: View {
    @State private var todoText: String = ""
    let onAdd: (String) -> Void
    let onCancel: () -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Add New Todo")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)
                
                TextField("Enter todo title", text: $todoText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .onSubmit {
                        addTodo()
                    }
                
                HStack(spacing: 16) {
                    Button("Cancel") {
                        onCancel()
                    }
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)
                    
                    Button("Add Todo") {
                        addTodo()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(todoText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(10)
                    .disabled(todoText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
    
    private func addTodo() {
        let trimmedText = todoText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedText.isEmpty {
            onAdd(trimmedText)
            todoText = ""
        }
    }
}

#Preview {
    AddTodoView(onAdd: { _ in }, onCancel: {})
}