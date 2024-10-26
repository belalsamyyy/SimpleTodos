//
//  SplashCoordinator.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

class SplashCoordinator: NavigationCoordinator {
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    
    //MARK: - Init
     
    init(navigationController: UINavigationController, delegate: CoordinatorDelegate) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    //MARK: - Start
     
    func start() {
        let splashVC = SplashVC(coordinator: self)
        navigationController.setViewControllers([splashVC], animated: true)
    }
    
    //MARK: - Finish
     
    func finish() {
        delegate?.coordinatorDidFinish(self)
    }
}
