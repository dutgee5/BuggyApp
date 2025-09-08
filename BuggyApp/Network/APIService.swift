import Foundation

protocol APIServiceDelegate: AnyObject {
    func didFetchTodos(_ todos: [ToDo])
}

class APIService {
    weak var delegate: APIServiceDelegate?

    func fetchTodos() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else { return }
        URLSession.shared.dataTask(with: url) { data, _, err in
            if let err = err {
                print("Error fetching todos: \(err.localizedDescription)")
                return
            }
            guard let data = data else { return }
            do {
                let todos = try JSONDecoder().decode([ToDo].self, from: data)
                DispatchQueue.main.async {
                    self.delegate?.didFetchTodos(todos)
                }
            } catch let err{
                print("Decoding error: \(err.localizedDescription)")
            }
        }.resume()
    }
}
