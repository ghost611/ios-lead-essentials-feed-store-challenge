import Foundation
import FeedStoreChallenge

public final class FeedStore: FeedStoreChallenge.FeedStore {
    
    public init() {
        
    }
    
    public func deleteCachedFeed(completion: @escaping FeedStore.DeletionCompletion) {
        
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping FeedStore.InsertionCompletion) {
        
    }
    
    public func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
        completion(.empty)
    }
}
