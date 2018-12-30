//
//  PersistentContainer.swift
//  EngineShed
//
//  Created by Scott James Remnant on 6/15/18.
//  Copyright © 2018 Scott James Remnant. All rights reserved.
//

import CloudKit
import CoreData

/// Subclass `NSPersistentContainer` place to correctly default the bundle for the data model.
///
/// This also turns out to be a useful place to connect the core data persistent store with the
/// CloudKit observer and provider.
public class PersistentContainer : NSPersistentContainer {

    /// Container identifier for CloudKit store.
    let cloudContainerID = "iCloud.com.netsplit.EngineShed"
    
    /// Subscription identifier registered for notifications.
    let subscriptionID = "private-changes"

    public private(set) var cloudContainer: CKContainer
    public private(set) var cloudDatabase: CKDatabase
    
    public private(set) var cloudObserver: CloudObserver!
    public private(set) var cloudProvider: CloudProvider!

    public override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        cloudContainer = CKContainer(identifier: cloudContainerID)
        cloudDatabase = cloudContainer.privateCloudDatabase

        super.init(name: name, managedObjectModel: model)

        cloudObserver = CloudObserver(database: cloudDatabase, persistentContainer: self)
        cloudProvider = CloudProvider(container: cloudContainer, database: cloudDatabase, persistentContainer: self)
    }
    
    public func syncWithCloud() {
        cloudObserver.subscribeToChanges()
        cloudObserver.fetchChanges()
        
        cloudProvider.observeChanges()
        cloudProvider.resumeLongLivedOperations()
    }
    
//    override public class func defaultDirectoryURL() -> URL {
//        return super.defaultDirectoryURL().appendingPathComponent("EngineShed")
//    }

}
