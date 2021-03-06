//
//  CoreDataStackProvider.swift
//  GiphySearch
//
//  Created by Noel Achkar on 23/11/2020.
//

import CoreData
import Foundation

/**
 An instance of `CoreDataStackProvider` is responsible for creating instances of `CoreDataStack`.
 
 Because the adding of the persistent store to the persistent store coordinator during initialization
 of a `CoreDataStack` can take an unknown amount of time, you should not perform this operation on the main queue.
 
 See this [guide](https://developer.apple.com/library/prerelease/ios/documentation/Cocoa/Conceptual/CoreData/IntegratingCoreData.html#//apple_ref/doc/uid/TP40001075-CH9-SW1) for more details.
 
 - warning: You should not create instances of `CoreDataStack` directly. Use a `CoreDataStackProvider` instead.
 */
public struct CoreDataStackProvider {

    // MARK: Typealiases

    /// Describes the initialization options for a persistent store.
    public typealias PersistentStoreOptions = [AnyHashable: Any]

    // MARK: Properties

    /// Describes default persistent store options.
    public static let defaultStoreOptions: PersistentStoreOptions = [
        NSMigratePersistentStoresAutomaticallyOption: true,
        NSInferMappingModelAutomaticallyOption: true
    ]

    /// The model for the stack that the factory produces.
    public let model: CoreDataModel

    /**
     A dictionary that specifies options for the store that the factory produces.
     The default value is `DefaultStoreOptions`.
     */
    public let options: PersistentStoreOptions?

    // MARK: Initialization

    /**
     Constructs a new `CoreDataStackProvider` instance with the specified `model` and `options`.
     
     - parameter model:   The model describing the stack.
     - parameter options: Options for the persistent store.
     
     - returns: A new `CoreDataStackProvider` instance.
     */
    public init(model: CoreDataModel, options: PersistentStoreOptions? = defaultStoreOptions) {
        self.model = model
        self.options = options
    }

    // MARK: Creating a stack

    /**
     Initializes a new `CoreDataStack` instance using the factory's `model` and `options`.
     
     - warning: If a queue is provided, this operation is performed asynchronously on the specified queue,
     and the completion closure is executed asynchronously on the main queue.
     If `queue` is `nil`, then this method and the completion closure execute synchronously on the current queue.
     
     - parameter queue: The queue on which to initialize the stack.
     The default is a background queue with a "user initiated" quality of service class.
     If passing `nil`, this method is executed synchronously on the queue from which the method was called.
     
     - parameter completion: The closure to be called once initialization is complete.
     If a queue is provided, this is called asynchronously on the main queue.
     Otherwise, this is executed on the thread from which the method was originally called.
     */
    public func createStack() -> CoreDataStack? {

        let storeCoordinator: NSPersistentStoreCoordinator!
        let stack: CoreDataStack!
        do {
            storeCoordinator = try self._createStoreCoordinator()
            let backgroundContext = self._createContext(.privateQueueConcurrencyType, name: "background")
            backgroundContext.persistentStoreCoordinator = storeCoordinator

            let mainContext = self._createContext(.mainQueueConcurrencyType, name: "main")
            mainContext.persistentStoreCoordinator = storeCoordinator

            stack = CoreDataStack(model: self.model,
                                  mainContext: mainContext,
                                  backgroundContext: backgroundContext,
                                  storeCoordinator: storeCoordinator)

            return stack
        } catch {
            print("Error store coordinator creation")
        }

        return nil
    }

    // MARK: Private

    private func _createStoreCoordinator() throws -> NSPersistentStoreCoordinator {
        let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model.managedObjectModel)
        try storeCoordinator.addPersistentStore(ofType: model.storeType.type,
                                                configurationName: nil,
                                                at: model.storeURL,
                                                options: options)
        return storeCoordinator
    }

    private func _createContext(_ concurrencyType: NSManagedObjectContextConcurrencyType,
                                name: String) -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: concurrencyType)
        context.mergePolicy = NSMergePolicy(merge: .mergeByPropertyStoreTrumpMergePolicyType)

        let contextName = "CoreDataStack.context."
        context.name = contextName + name

        return context
    }
}
extension CoreDataStackProvider: Equatable {
    /// :nodoc:
    public static func == (lhs: CoreDataStackProvider, rhs: CoreDataStackProvider) -> Bool {
        lhs.model == rhs.model
    }
}
