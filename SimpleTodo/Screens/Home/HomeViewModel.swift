//
//  HomeViewModel.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation
import Combine

//MARK: - View Model

class HomeViewModel {
    
    //MARK: - Init
     
    private var coordinator: HomeCoordinator
    private var repository: TodoRepository
     
    init(coordinator: HomeCoordinator, repository: TodoRepository = DefaultTodoRepository()) {
        self.coordinator = coordinator
        self.repository = repository
    }
}

//MARK: - Input

extension HomeViewModel: HomeViewModelInput {}

//MARK: - Output

extension HomeViewModel: HomeViewModelOutput {}

