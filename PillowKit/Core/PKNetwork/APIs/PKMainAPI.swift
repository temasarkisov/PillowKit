import Foundation

public class DefaultPKMainAPI {
    let networkService: HTTPNetworkService
    
    init(networkService: HTTPNetworkService) {
        self.networkService = networkService
    }
}

extension DefaultPKMainAPI: PKMainAPIProtocol {
    public func viewsData(
        endpoint: PKEndpoint,
        viewsDataName: String,
        completion: @escaping (Result<PKViewsDataResponseEntity, Error>) -> Void
    ) {
        let request = ViewsDataRequest(
            endpoint: endpoint,
            viewsDataName: viewsDataName
        )
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
