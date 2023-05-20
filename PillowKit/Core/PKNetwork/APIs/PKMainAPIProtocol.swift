import Foundation

public protocol PKMainAPIProtocol: AnyObject {
    func viewsData(
        endpoint: PKEndpoint,
        completion: @escaping (Result<PKViewsDataResponseEntity, Error>) -> Void
    )
}
