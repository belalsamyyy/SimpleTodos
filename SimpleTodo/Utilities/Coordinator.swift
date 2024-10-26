//
//  Coordinator.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
}

protocol NavigationCoordinator: Coordinator {
    var delegate: CoordinatorDelegate? { get }
    var navigationController: UINavigationController { get }
    func finish()
}

protocol CoordinatorDelegate: AnyObject {
    func coordinatorDidFinish(_ coordinator: Coordinator)
}

