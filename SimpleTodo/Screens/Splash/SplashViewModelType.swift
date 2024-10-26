//
//  SplashViewModelType.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation

//MARK: - Type

typealias SplashViewModelType = SplashViewModelInput & SplashViewModelOutput

//MARK: - Input

protocol SplashViewModelInput {
    // user inputs & actions
}

//MARK: - Output

protocol SplashViewModelOutput {
    // state changes & results
    func setupFirstScreen()
}
