//
//  CoreDataStorage.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation
import CoreData

class CoreDataStorage: NSObject {
    
    public let modelName = "CoreDataStorage"
    public let modelBundle = Bundle.main
    
    var stack: CoreDataStack!
    
    class var sharedInstance: CoreDataStorage {
        struct Static {
            static let instance: CoreDataStorage = CoreDataStorage()
        }
        
        return Static.instance
    }
    
    override init() {
        super.init()
        
        let model = CoreDataModel(name: modelName, bundle: modelBundle)
        let factory = CoreDataStackProvider(model: model)
        
        self.stack = factory.createStack()
    }
    
    var managedObjectContext: NSManagedObjectContext {
        return self.stack.backgroundContext
    }
    
    var mainManagedObjectContext: NSManagedObjectContext {
        return self.stack.mainContext
    }
    
    func fetchBlock(block: @escaping (_ context: NSManagedObjectContext) -> Void) {
        let mainContext = self.mainManagedObjectContext
        mainContext.performAndWait {
            block(mainContext)
        }
    }
    
    typealias DeleteCompletionHandler = () -> Void
    func removeBlock(block: @escaping (_ context: NSManagedObjectContext) -> Void, completionHandler : @escaping DeleteCompletionHandler) {
        let mainContext = self.mainManagedObjectContext
        mainContext.performAndWait {
            block(mainContext)
            mainContext.saveSync()
        }
        
        completionHandler()
    }
    
    func executeBlock(block: @escaping (_ context: NSManagedObjectContext) -> Void) {
        let backgroundChildContext = self.stack.childContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundChildContext.performAndWait {
            block(backgroundChildContext)
            backgroundChildContext.saveSync()
        }
    }
    
    func scheduleBlock(block: @escaping (_ context: NSManagedObjectContext) -> Void) {
        let backgroundChildContext = self.stack.childContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundChildContext.perform {
            block(backgroundChildContext)
            backgroundChildContext.saveSync()
        }
    }
    
    typealias CompletionHandler = () -> Void
    func executeBlock(block: @escaping (_ context: NSManagedObjectContext) -> Void, completionHandler : @escaping CompletionHandler) {
        let backgroundChildContext = self.stack.childContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundChildContext.performAndWait {
            block(backgroundChildContext)
            backgroundChildContext.saveSync()
        }
        
        completionHandler()
    }
}
