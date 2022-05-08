import CoreData

final class CoreDataStack {

    private let objectModelName = "DataStore"
    private let objectModelExtension = "momd"

    static var shared = CoreDataStack()

    private init() {}

    lazy var managedContext: NSManagedObjectContext = {
        let context = persistenceContainer.viewContext
        return context
    }()

    lazy var backgroundContext: NSManagedObjectContext = {
        let backgroundContext = persistenceContainer.newBackgroundContext()
        backgroundContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return backgroundContext
    }()

    private lazy var persistenceContainer: NSPersistentContainer = {
        let bundle = Bundle(for: type(of: self))
        guard
            let modelURL = bundle.url(
                forResource: objectModelName,
                withExtension: objectModelExtension
            ),
            let managedObjectModel = NSManagedObjectModel(
                contentsOf: modelURL
            )
        else {
            // We should crash in this case since we can not create/retrieve a
            // `ManagedObjectModel` for our database on this device.
            fatalError(
                "Could not retrieve the ManagedObjectModel within the app's bundle."
            )
        }

        let container = NSPersistentContainer(name: objectModelName, managedObjectModel: managedObjectModel)

        container.loadPersistentStores { _, error in
            if let error = error {
                // We should crash in this case since we can not create a
                // database on this device.
                fatalError(
                    "Unable to load/create persistent stores."
                )
            }
        }

        return container
    }()
}
