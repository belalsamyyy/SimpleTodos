//
//  TodoNetworking.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation
import UIKit

//MARK: - Protocol

protocol TodoNetworking {
    func getTodoList(search: String, completed: @escaping (Result<[TodoListItemModel], STError>) -> Void)
}

//MARK: - Requests

struct DefaultTodoNetworking: TodoNetworking {
    private let service: NetworkManager
    
    init(service: NetworkManager = .shared) {
        self.service = service
    }
     
    func getTodoList(search: String, completed: @escaping (Result<[TodoListItemModel], STError>) -> Void) {
        let endPoint = "todos"
        service.baseNetworkCall(for: [:], body: nil, endPoint: endPoint, type: BaseModel<TodoListItemModel>.self, method: .get) { result in
            switch result {
            case .success(let result):
                let filteredData = !search.isEmpty ? result.data.filter { $0.title.contains(search) } : result.data
                completed(.success(filteredData))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
}
