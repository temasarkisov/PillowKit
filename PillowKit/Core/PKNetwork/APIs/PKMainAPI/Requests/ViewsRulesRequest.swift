import Foundation


public struct ViewsDataRequest {
    public typealias Response = PKViewsDataResponseEntity
    private var endpoint: PKEndpoint
    private var viewsDataName: String
    
    public init(
        endpoint: PKEndpoint,
        viewsDataName: String
    ) {
        self.endpoint = endpoint
        self.viewsDataName = viewsDataName
    }
}

extension ViewsDataRequest: HTTPRequest {
    public var url: String {
        endpoint.absolutePath
    }
    
    public var queryItems: [String : String] {
        ["name": viewsDataName]
    }
    
    public var method: HTTPMethod {
        .get
    }
}


