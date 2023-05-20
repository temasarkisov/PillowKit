import UIKit

final class PKProvider {
    private let API: PKMainAPIProtocol
    
    init(API: PKMainAPIProtocol) {
        self.API = API
    }
    
    func fetchViewsData(
        endpoint: PKEndpoint,
        completion: @escaping (Result<PKViewsData, Error>) -> Void
    ) {
        API.viewsData(
            endpoint: endpoint,
            completion: { result in
                switch result {
                case .success(let viewsDataResponseEntity):
                    print(viewsDataResponseEntity)
                    completion(.success(PKViewsData(viewsDataResponseEntity)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}
