//
//  TodoLocalService.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation
import CoreData

class TodoLocalService {
    static let shared = TodoLocalService()
    private init() {}
    
    //MARK: - Fetch
     
    func fetchTodos(search: String, completed: @escaping (Result<[TodoListItemModel], STError>) -> Void) {
        let context = CoreDataStore.shared.context
        let request = TodoListItem.fetchRequest()
        
        if !search.isEmpty {
            request.predicate = NSPredicate(format: "title CONTAINS %@", search.lowercased())
        }
         
        do {
            let items = try context.fetch(request)
            let todos = items.map { item in
                TodoListItemModel(title: item.title, completed: item.isCompleted, coreDataID: item.id)
            }
            completed(.success(todos))
             
        } catch {
            completed(.failure(.coreDataError))
        }
    }
    
    //MARK: - Add
      
    func addTodo(_ todo: TodoListItemModel, completed: @escaping (Result<EmptyModel?, STError>) -> Void) {
        let context = CoreDataStore.shared.context
         
        let item = TodoListItem(context: context)
        item.id = todo.coreDataID ?? UUID()
        item.title = todo.title
        item.isCompleted = todo.completed
 
        do {
            try context.save()
            completed(.success(nil))
        } catch {
            completed(.failure(.coreDataError))
        }
    }
    
    //MARK: - Delete

    func removeTodo(_ todo: TodoListItemModel, completed: @escaping (Result<EmptyModel?, STError>) -> Void) {
        let context = CoreDataStore.shared.context
        let request = TodoListItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", todo.coreDataID! as CVarArg)
         
        do {
            let items = try context.fetch(request)
            for item in items {
                context.delete(item)
            }
            
            try context.save()
            completed(.success(nil))
        } catch {
            completed(.failure(.coreDataError))
        }
    }
     
    //MARK: - Mark As Completed
     
    func updateTodo(_ todo: TodoListItemModel, markAsCompleted: Bool, completed: @escaping (Result<EmptyModel?, STError>) -> Void) {
        let context = CoreDataStore.shared.context
        let request = TodoListItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", todo.coreDataID! as CVarArg)

        do {
            let items = try context.fetch(request)
            if let newItem = items.first {
                newItem.isCompleted = markAsCompleted
                try context.save()
                completed(.success(nil))
                 
            } else {
                completed(.failure(.customValue("not found")))
            }
                          
        } catch {
            completed(.failure(.coreDataError))
        }
    }
}

