//
//  TodoRepository.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import CoreData
import Foundation

//MARK: - Protocol

protocol TodoRepository {
    func fetchPlaceholders(search: String, completed: @escaping (Result<[TodoListItemModel], STError>) -> Void)
    func fetchTodos(search: String, completed: @escaping (Result<[TodoListItemModel], STError>) -> Void)
    func addTodo(_ todo: TodoListItemModel, completed: @escaping (Result<EmptyModel?, STError>) -> Void)
    func removeTodo(_ todo: TodoListItemModel, completed: @escaping (Result<EmptyModel?, STError>) -> Void)
    func updateTodo(_ todo: TodoListItemModel, markAsCompleted: Bool, completed: @escaping (Result<EmptyModel?, STError>) -> Void)
}

//MARK: - API Service

struct DefaultTodoRepository: TodoRepository {
    private var localService: TodoLocalService
    private var remoteService: DefaultTodoNetworking
     
    init(localService: TodoLocalService = TodoLocalService.shared, remoteService: DefaultTodoNetworking = DefaultTodoNetworking()) {
        self.localService = localService
        self.remoteService = remoteService
    }
    
    // Remote
    func fetchPlaceholders(search: String, completed: @escaping (Result<[TodoListItemModel], STError>) -> Void) {
        remoteService.getTodoList(search: search, completed: completed)
    }
     
    // Local
    func fetchTodos(search: String, completed: @escaping (Result<[TodoListItemModel], STError>) -> Void) {
        localService.fetchTodos(search: search) { result in
            switch result {
            case .success(let todos):
                completed(.success(todos))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func addTodo(_ todo: TodoListItemModel, completed: @escaping (Result<EmptyModel?, STError>) -> Void) {
        localService.addTodo(todo, completed: completed)
    }
    
    func removeTodo(_ todo: TodoListItemModel, completed: @escaping (Result<EmptyModel?, STError>) -> Void) {
        localService.removeTodo(todo, completed: completed)
    }
    
    func updateTodo(_ todo: TodoListItemModel, markAsCompleted: Bool, completed: @escaping (Result<EmptyModel?, STError>) -> Void) {
        localService.updateTodo(todo, markAsCompleted: markAsCompleted, completed: completed)
    }
}

