import Foundation


public struct ViewsDataRequest {
    public typealias Response = PKViewsDataResponseEntity
    private var endpoint: PKEndpoint
    
    public init(endpoint: PKEndpoint) {
        self.endpoint = endpoint
    }
}

extension ViewsDataRequest: HTTPRequest {
    public var url: String {
        self.endpoint.absolutePath
    }
    
    public var method: HTTPMethod {
        .get
    }
}


