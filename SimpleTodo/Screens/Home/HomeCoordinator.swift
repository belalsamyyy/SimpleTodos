//
//  HomeCoordinator.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

class HomeCoordinator: NavigationCoordinator, CoordinatorDelegate {
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    private var children: [HomeChildCoordinator: Coordinator] = [:]

    //MARK: - Init
     
    init(navigationController: UINavigationController, delegate: CoordinatorDelegate) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    enum HomeChildCoordinator {
        case examples
    }
     
    //MARK: - Start
     
    func start() {
        let homeVC = HomeVC(coordinator: self)
        navigationController.setViewControllers([homeVC], animated: true)
    }
    
    func startExamplesFlow() {
        let examplesCoordinator = ExamplesCoordinator(navigationController: navigationController, delegate: self)
        children[.examples] = examplesCoordinator
        examplesCoordinator.start()
    }
    
    //MARK: - Finish
     
    func finish() {
        delegate?.coordinatorDidFinish(self)
    }
     
    func coordinatorDidFinish(_ coordinator: any Coordinator) {
        if coordinator === children[.examples] {
            children.removeValue(forKey: .examples)
        }
    }
}
