import Foundation

public protocol PKMainAPIProtocol: AnyObject {
    func viewsData(
        endpoint: PKEndpoint,
        viewsDataName: String,
        completion: @escaping (Result<PKViewsDataResponseEntity, Error>) -> Void
    )
}
