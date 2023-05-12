import Foundation


public struct ViewsRulesRequest {
    public typealias Response = PKViewsDataResponseEntity
    
    public init() {}
}

extension ViewsRulesRequest: HTTPRequest {
    public var url: String {
        PKEndpoint.viewsRules.absolutePath
    }
    
    public var method: HTTPMethod {
        .get
    }
}


