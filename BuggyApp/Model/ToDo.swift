import Foundation

struct ToDo: Codable {
    let id: Int
    let title: String
    let completed: Bool
    let userID: Int
    
    enum ToDoKeys: String, CodingKey {
        case id, title, completed
        case userID = "userId"
    }
}  
