//
//  ExamplesViewModel.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation
import Combine

//MARK: - Delegate

protocol ExamplesViewModelDelegate: AnyObject {
    func reloadData()
    func didExitWithError(error: String)
}

//MARK: - View Model

class ExamplesViewModel {
    var placeholders = CurrentValueSubject<[TodoListItemModel], Never>([])
    var errorMessage = CurrentValueSubject<String, Never>("")
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    
    //MARK: - Init
     
    private var delegate: ExamplesViewModelDelegate
    private var coordinator: ExamplesCoordinator
    private var repository: TodoRepository
     
    init(delegate: ExamplesViewModelDelegate, coordinator: ExamplesCoordinator, repository: TodoRepository = DefaultTodoRepository()) {
        self.delegate = delegate
        self.coordinator = coordinator
        self.repository = repository
    }
}

//MARK: - Iutput

extension ExamplesViewModel: ExamplesViewModelInput {
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
     
    func addTodo(_ todo: TodoListItemModel) {
        repository.addTodo(todo) { [weak self] result in
            switch result {
            case .success:
                self?.delegate.reloadData()
                 
            case .failure(let error):
                self?.delegate.didExitWithError(error: error.value)
            }
        }
    }
}

//MARK: - Output

extension ExamplesViewModel: ExamplesViewModelOuput {
    var isEmpty: Bool {
        return placeholders.value.isEmpty
    }
     
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfCells(section: Int) -> Int {
        switch section {
        case 0:
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
            return placeholders.value.get(at: index)
        default:
            return nil
        }
    }
    
    func restartPlaceholders() {
        placeholders.send([])
        getPlaceholders()
    }
}

