//
//  UIWindow+Ext.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

extension UIWindow {
    func replaceRootViewController(_ viewController: UIViewController) {
        self.rootViewController = viewController
        self.makeKeyAndVisible()
    }
}
