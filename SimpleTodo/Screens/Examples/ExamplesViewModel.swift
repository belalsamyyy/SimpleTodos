//
//  ExamplesViewModel.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation
import Combine

//MARK: - View Model

class ExamplesViewModel {
    
    //MARK: - Init
     
    private var coordinator: ExamplesCoordinator
    private var repository: TodoRepository
     
    init(coordinator: ExamplesCoordinator, repository: TodoRepository = DefaultTodoRepository()) {
        self.coordinator = coordinator
        self.repository = repository
    }
}

//MARK: - Iutput

extension ExamplesViewModel: ExamplesViewModelInput {}

//MARK: - Output

extension ExamplesViewModel: ExamplesViewModelOuput {}

