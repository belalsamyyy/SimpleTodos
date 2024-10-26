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
     
    var rootWindow: UIWindow { window }

    init(window: UIWindow) {
        self.window = window
    }
     
    enum AppChildCoordinator {
        case splash
        case home
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
     
    func startHomeFlow() {
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController, delegate: self)
        children[.home] = homeCoordinator
        homeCoordinator.start()
        window.replaceRootViewController(homeNavigationController)
    }
    
    //MARK: - Finish
     
    func coordinatorDidFinish(_ coordinator: any Coordinator) {
        if coordinator === children[.splash] {
            children.removeValue(forKey: .splash)
            startHomeFlow()
            
        } else if coordinator === children[.home] {
            children.removeValue(forKey: .home)
        }
    }
}

