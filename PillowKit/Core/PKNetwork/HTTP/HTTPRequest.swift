import Foundation


public protocol HTTPRequest {
    associatedtype Response
    
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String] { get }
    var queryItems: [String : String] { get }
    var body: [String: Any] { get }
    
    func decode(_ data: Data) throws -> Response
}

extension HTTPRequest {
    public var headers: [String : String] { [:] }
    public var queryItems: [String : String] { [:] }
    public var body: [String : Any] { [:] }
}

extension HTTPRequest where Response: Decodable {
    public func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(
            Response.self,
            from: data
        )
    }
}
