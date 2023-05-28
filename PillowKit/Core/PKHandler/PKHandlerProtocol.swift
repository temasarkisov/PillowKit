import UIKit

protocol PKHandlerProtocol: AnyObject {
    func buildContainer(
        endpoint: PKEndpoint,
        viewsDataName: String,
        completion: @escaping(Result<PKContainer, Error>) -> Void
    )
    
    func obtainContainer() -> PKContainer
    
    func obtainView(by viewID: String) -> PKView?
}
