//
//  ExamplesViewModelType.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation
import Combine

//MARK: - Type

typealias ExamplesViewModelType = ExamplesViewModelInput & ExamplesViewModelOuput

//MARK: - Input

protocol ExamplesViewModelInput {
    // user inputs & actions
    func getPlaceholders(search: String)
    func addTodo(_ todo: TodoListItemModel)
}

//MARK: - Output
 
protocol ExamplesViewModelOuput {
    // state changes & results
    var placeholders: CurrentValueSubject<[TodoListItemModel], Never> { get set }
    var errorMessage: CurrentValueSubject<String, Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var isEmpty: Bool { get }
    var numberOfSections: Int { get }
    func numberOfCells(section: Int) -> Int
    func heightForRow(section: Int) -> CGFloat
    func todo(section: Int, index: Int) -> TodoListItemModel?
    func restartPlaceholders()
}
