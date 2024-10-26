//
//  CoreDataStore.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import CoreData
import UIKit

class CoreDataStore {
    
    //MARK: - Singleton Manager
    
    static let shared = CoreDataStore()
    private init() {}
    
    //MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SimpleTodo")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Core Data (PersistentContainer) Error: \(error), \(error.userInfo)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
     
    //MARK: - Main Context for UI
     
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
     
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Core Data (Save Context) Error: \(nserror), \(nserror.userInfo)")
            }
        }
    }

    //MARK: - Background Context for asynchronous tasks
    
    var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func saveBackgroundContext() {
        let context = backgroundContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Core Data (Save Background Context) Error: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
