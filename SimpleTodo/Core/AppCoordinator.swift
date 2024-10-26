//
//  AppCoordinator.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

class AppCoordinator: Coordinator, CoordinatorDelegate  {
    private let window: UIWindow
    private var children: [AppChildCoordinator: Coordinator] = [:]

    //MARK: - Init
     
    init(window: UIWindow) {
        self.window = window
    }
    
    enum AppChildCoordinator {
        case splash
    }
    
    //MARK: - Start
     
    func start() {
        startSplashFlow()
    }
     
    func startSplashFlow() {
        let splashNavigationController = UINavigationController()
        let splashCoordinator = SplashCoordinator(navigationController: splashNavigationController, delegate: self)
        children[.splash] = splashCoordinator
        splashCoordinator.start()
        window.replaceRootViewController(splashNavigationController)
    }
    
    //MARK: - Finish
     
    func coordinatorDidFinish(_ coordinator: any Coordinator) {}
}

