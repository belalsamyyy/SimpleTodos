//
//  UITableView+Ext.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

extension UITableView {
    // register
    func registerNib<T: UITableViewCell>(_: T.Type) {
        let name = String(describing: T.self)
        register(UINib(nibName: name, bundle: Bundle(for: T.self)), forCellReuseIdentifier: name)
    }
    
    // dequeue
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not dequeue cell with type \(T.self)")
        }
        return cell
    }
}

extension Collection {
    func get(at index: Index) -> Iterator.Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
