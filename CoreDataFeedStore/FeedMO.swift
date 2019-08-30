import CoreData

@objc(FeedMO)
final class FeedMO: NSManagedObject {
    
    @nonobjc
    class var request: NSFetchRequest<FeedMO> {
        return NSFetchRequest<FeedMO>(entityName: "Feed")
    }
    
    @NSManaged
    var date: Date?
    
    @NSManaged
    var feed: [FeedImageTransformable]?
}
