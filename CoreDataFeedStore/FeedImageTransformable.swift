import Foundation

@objc(FeedImageTransformable)
final class FeedImageTransformable: NSObject {
    
    let identifier: UUID
    let text: String?
    let location: String?
    let url: URL
    
    init(identifier: UUID, text: String?, location: String?, url: URL) {
        self.identifier = identifier
        self.text = text
        self.location = location
        self.url = url
    }
}
