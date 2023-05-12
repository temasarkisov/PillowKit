import Foundation

private let logger = Logger()

public protocol PKMainAPI: AnyObject {
    func viewsData(
        completion: @escaping (Result<PKViewsDataResponseEntity, Error>) -> Void
    )
}

public class DefaultPKMainAPI {
    let networkService: HTTPNetworkService
    
    init(networkService: HTTPNetworkService) {
        self.networkService = networkService
    }
}

extension DefaultPKMainAPI: PKMainAPI {
    public func viewsData(
        completion: @escaping (Result<PKViewsDataResponseEntity, Error>) -> Void
    ) {
        let request = ViewsRulesRequest()
        networkService.request(
            request,
            queue: .main
        ) { result in
            switch result {
            case .success(let responseEntity):
                completion(.success(responseEntity))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
