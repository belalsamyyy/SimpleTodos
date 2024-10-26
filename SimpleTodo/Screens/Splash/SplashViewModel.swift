//
//  SplashViewModel.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation

//MARK: - View Model

class SplashViewModel: SplashViewModelType {
    private weak var coordinator: NavigationCoordinator?
    
    //MARK: - Init
     
    init(coordinator: SplashCoordinator?) {
        self.coordinator = coordinator
    }
     
    func setupFirstScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self else { return }
            self.coordinator?.finish()
        }
    }
}

