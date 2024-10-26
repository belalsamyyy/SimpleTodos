//
//  TodoListItem+CoreDataProperties.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//
//

import Foundation
import CoreData

extension TodoListItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoListItem> {
        return NSFetchRequest<TodoListItem>(entityName: "TodoListItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var isCompleted: Bool
}

extension TodoListItem : Identifiable {}
