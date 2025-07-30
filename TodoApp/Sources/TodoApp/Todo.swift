import Foundation

struct Todo: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
    mutating func toggle() {
        isCompleted.toggle()
    }
}