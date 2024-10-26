//
//  HomeViewModelType.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation
import Combine

//MARK: - Type

typealias HomeViewModelType = HomeViewModelInput & HomeViewModelOutput

//MARK: - Input

protocol HomeViewModelInput {
    // user inputs & actions
    var search: CurrentValueSubject<String, Never> { get set }
    func getPlaceholders(search: String)
    func getTodoList(search: String)
    func addTodo(_ todo: TodoListItemModel)
    func deleteTodo(_ todo: TodoListItemModel)
    func toggleCompleted(_ todo: TodoListItemModel, isCompleted: Bool)
}

//MARK: - Output
 
protocol HomeViewModelOutput {
    // state changes & results
    var placeholders: CurrentValueSubject<[TodoListItemModel], Never> { get set }
    var todos: CurrentValueSubject<[TodoListItemModel], Never> { get set }
    var errorMessage: CurrentValueSubject<String, Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var isEmpty: Bool { get }
    var numberOfSections: Int { get }
    func headerTitle(section: Int) -> String?
    func numberOfCells(section: Int) -> Int
    func heightForRow(section: Int) -> CGFloat
    func todo(section: Int, index: Int) -> TodoListItemModel?
    func restartPlaceholders()
    func restartTodoList()
}
