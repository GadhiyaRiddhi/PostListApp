//
//  PersistanceService.swift
//  PostsViewer
//
//  Created by keyur.tailor on 24/02/21.
//  Copyright © 2021 keyur.tailor. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    // MARK: - Core Data stack
    
    private init() { }
    
    static let shared = CoreDataStack()
    
    lazy var context = persistentContainer.viewContext
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
//                print("SAVED")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<Post: NSManagedObject>() -> [Post] {
        let entityName = String(describing: Post.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [Post]
            return fetchedObjects ?? [Post]()
        } catch {
            print(error)
            return [Post]()
        }
    }
    
    func delete(_ object:NSManagedObject) {
        context.delete(object)
        saveContext()
    }
    
    func isEntityAttributeExist(id: Int, entityName: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        let res = try! context.fetch(fetchRequest)
        return res.count > 0 ? true : false
    }
}
