import FeedStoreChallenge
import CoreData

public final class FeedStore: FeedStoreChallenge.FeedStore {
    
    public init() {
        let bundle = Bundle(identifier: "com.essentialdeveloper.FeedStoreChallenge.ghost611.CoreDataFeedStore")!
        let url = bundle.url(forResource: "FeedStore", withExtension: "momd")!
        let mom = NSManagedObjectModel(contentsOf: url)!
        persistentContainer = NSPersistentContainer(name: "FeedStore", managedObjectModel: mom)
        
        let description = NSPersistentStoreDescription(url: url)
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [
            description
        ]
        
        persistentContainer.loadPersistentStores { _, _ in }
    }
    
    public func deleteCachedFeed(completion: @escaping FeedStore.DeletionCompletion) {
        
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping FeedStore.InsertionCompletion) {
        let moc = persistentContainer.viewContext
        
        let mo = FeedMO(context: moc)
        mo.feed = feed.map { FeedImageTransformable(feedImage: $0) }
        mo.date = timestamp
        
        try! moc.save()
        
        completion(nil)
    }
    
    public func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
        let moc = persistentContainer.viewContext
        
        let result: RetrieveCachedFeedResult
        
        let mos = try! moc.fetch(FeedMO.request)
        if let mo = mos.first {
            let feed = mo.feed!.map { LocalFeedImage(feedImage: $0) }
            let timestamp = mo.date!
            result = .found(feed: feed, timestamp: timestamp)
        } else {
            result = .empty
        }
        
        completion(result)
    }
    
    private let persistentContainer: NSPersistentContainer
}

private extension FeedImageTransformable {
    
    convenience init(feedImage: LocalFeedImage) {
        self.init(identifier: feedImage.id, text: feedImage.description, location: feedImage.location, url: feedImage.url)
    }
}

private extension LocalFeedImage {
    
    init(feedImage: FeedImageTransformable) {
        self.init(id: feedImage.identifier, description: feedImage.text, location: feedImage.location, url: feedImage.url)
    }
}
