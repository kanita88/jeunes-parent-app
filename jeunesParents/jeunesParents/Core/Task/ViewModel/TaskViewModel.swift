//
//  TaskViewModel.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 21/10/2024.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    func fetchTasks() {
        guard let url = URL(string: "http://127.0.0.1:8080/task") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let tasks = try? decoder.decode([Task].self, from: data) {
                    DispatchQueue.main.async {
                        self.tasks = tasks
                    }
                }
            }
        }.resume()
    }

    func addTask(title: String, completed: Bool) {
        guard let url = URL(string: "http://127.0.0.1:8080/task") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = Task(nom: "", tache: "", completed: Bool())
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(task) {
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let newTask = try? decoder.decode(Task.self, from: data) {
                        DispatchQueue.main.async {
                            self.tasks.append(newTask)
                        }
                    }
                }
            }.resume()
        }
    }
}
