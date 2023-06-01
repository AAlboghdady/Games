//
//  CoreDataHandler.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 31/05/2023.
//

import Foundation
import CoreData

protocol CoreDataHandlerProtocol {
    func getContext() -> NSManagedObjectContext
    func createEntity<T: NSManagedObject>(_ object: T.Type) -> T?
    func fetchEntities<T: NSManagedObject>(ofType entityClass: T.Type) -> [T]
    func saveContext()
}

class CoreDataHandler: CoreDataHandlerProtocol {
    
    private let persistentContainer: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    static let shared = CoreDataHandler(modelName: "Game")

    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Failed to load persistent stores: \(error), \(error.userInfo)")
            }
        }
        context = persistentContainer.viewContext
    }

    func getContext() -> NSManagedObjectContext {
        return context
    }

    func createEntity<T: NSManagedObject>(_ object: T.Type) -> T? {
        guard let entityName = T.entity().name else {
            return nil
        }
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? T
    }

    func fetchEntities<T: NSManagedObject>(ofType entityClass: T.Type) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: entityClass))
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch entities: \(error)")
            return []
        }
    }
    
    func deleteEntity<T: NSManagedObject>(_ entity: T) {
        context.delete(entity)
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
