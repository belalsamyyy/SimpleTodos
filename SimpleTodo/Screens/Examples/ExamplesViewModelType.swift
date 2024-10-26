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
}

//MARK: - Output
 
protocol ExamplesViewModelOuput {
    // state changes & results
}
