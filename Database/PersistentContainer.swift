//
//  PersistentContainer.swift
//  EngineShed
//
//  Created by Scott James Remnant on 1/28/20.
//  Copyright © 2020 Scott James Remnant. All rights reserved.
//

import CoreData

/// Subclass `NSPersistentContainer` place to correctly default the bundle for the data model.
///
/// This also turns out to be a useful place to connect the core data persistent store with the
/// CloudKit observer and provider.
#if DEBUG
public final class PersistentContainer: NSPersistentCloudKitContainer {
    private override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)
    }
}
#else
public final class PersistentContainer: NSPersistentContainer {
    private override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)
    }
}
#endif

extension PersistentContainer {
    /// Shared container instance.
    ///
    /// This is used to ensure the running app, and unit tests running within it, share the same
    /// `managedObjectModel`.
    public static let shared: PersistentContainer = {
        ValueTransformer.setValueTransformer(
            SecureUnarchiveDateComponentsFromDataTransformer(),
            forName: NSValueTransformerName(rawValue: "SecureUnarchiveDateComponentsFromDataTransformer"))

        return PersistentContainer(name: "EngineShed")
    }()
}
