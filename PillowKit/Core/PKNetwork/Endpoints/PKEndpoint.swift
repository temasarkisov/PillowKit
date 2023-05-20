import Foundation


public struct PKEndpoint {
    let url: String
    
    public init(url: String) {
        self.url = url
    }
}

extension PKEndpoint {
    public var absolutePath: String {
        PKSecret.host + self.url
    }
}
