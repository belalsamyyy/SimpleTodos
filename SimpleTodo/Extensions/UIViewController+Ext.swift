//
//  UIViewController+Ext.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

extension UIViewController {
    func presentAlertWithTextField(title: String, message: String, actionTitle: String, action: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: { _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else { return }
            action(text)
        }))
        
        self.present(alert, animated: true)
    }
}
