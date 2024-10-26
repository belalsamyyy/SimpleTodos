//
//  HomeViewModel.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation
import Combine

//MARK: - Delegate

protocol HomeViewModelDelegate: AnyObject {
    func reloadData()
    func didExitWithError(error: String)
}

//MARK: - View Model

class HomeViewModel {
    var search = CurrentValueSubject<String, Never>("")
    var placeholders = CurrentValueSubject<[TodoListItemModel], Never>([])
    var todos = CurrentValueSubject<[TodoListItemModel], Never>([])
    var errorMessage = CurrentValueSubject<String, Never>("")
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    
    //MARK: - Init
    
    private var delegate: HomeViewModelDelegate
    private var coordinator: HomeCoordinator
    private var repository: TodoRepository
    
    init(delegate: HomeViewModelDelegate, coordinator: HomeCoordinator, repository: TodoRepository = DefaultTodoRepository()) {
        self.delegate = delegate
        self.coordinator = coordinator
        self.repository = repository
    }
}

//MARK: - Input

extension HomeViewModel: HomeViewModelInput {
    
    // CRUD Operations
    
    func getPlaceholders(search: String = "") {
        isLoading.send(true)
        repository.fetchPlaceholders(search: search) { [weak self] result in
            guard let self = self else { return }
            self.isLoading.send(false)
            switch result {
            case .success(let placeholders):
                self.placeholders.send(placeholders)
                self.delegate.reloadData()
                 
            case .failure(let error):
                self.delegate.didExitWithError(error: error.value)
            }
        }
    }
     
    func getTodoList(search: String = "") {
       isLoading.send(true)
       repository.fetchTodos(search: search) { [weak self] result in
           guard let self = self else { return }
           self.isLoading.send(false)
           switch result {
           case .success(let todos):
               self.todos.send(todos)
               self.delegate.reloadData()
               
           case .failure(let error):
               self.delegate.didExitWithError(error: error.value)
           }
       }
    }
     
    func addTodo(_ todo: TodoListItemModel) {
        repository.addTodo(todo) { [weak self] result in
            switch result {
            case .success:
                self?.todos.value.append(todo)
                self?.getTodoList()
                 
            case .failure(let error):
                self?.delegate.didExitWithError(error: error.value)
            }
        }
    }
     
    func toggleCompleted(_ todo: TodoListItemModel, isCompleted: Bool) {
        repository.updateTodo(todo, markAsCompleted: !isCompleted) { [weak self] result in
            switch result {
            case .success:
                self?.getTodoList()
                 
            case .failure(let error):
                self?.delegate.didExitWithError(error: error.value)
            }
        }
    }
     
    func deleteTodo(_ todo: TodoListItemModel) {
        repository.removeTodo(todo) { [weak self] result in
            switch result {
            case .success:
                self?.getTodoList()
                
            case .failure(let error):
                self?.delegate.didExitWithError(error: error.value)
            }
        }
    }
}

//MARK: - Output

extension HomeViewModel: HomeViewModelOutput {
    var isEmpty: Bool {
        return todos.value.isEmpty
    }
    
    var numberOfSections: Int {
        return 2
    }
     
    func headerTitle(section: Int) -> String? {
        switch section {
        case 0:
            return "My Todos (Local)"
        case 1:
            return "Examples (Remote)"
        default:
            return nil
        }
    }
     
    func numberOfCells(section: Int) -> Int {
        switch section {
        case 0:
            return todos.value.count
        case 1:
            return placeholders.value.count
        default:
            return 0
        }
    }
     
    func heightForRow(section: Int) -> CGFloat {
        switch section {
        case 0:
            return 50
        default:
            return 0
        }
    }
     
    func todo(section: Int, index: Int) -> TodoListItemModel? {
        switch section {
        case 0:
            return todos.value.get(at: index)
        case 1:
            return placeholders.value.get(at: index)
        default:
            return nil
        }
    }
     
    func restartPlaceholders() {
        placeholders.send([])
        getPlaceholders()
    }
    
    func restartTodoList() {
        todos.send([])
        getTodoList()
    }
}
