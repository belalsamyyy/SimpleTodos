//
//  AppCoordinator.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

class AppCoordinator: Coordinator  {
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
     
    func start() {}
}

