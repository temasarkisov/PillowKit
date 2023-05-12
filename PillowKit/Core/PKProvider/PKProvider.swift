import UIKit

final class PKProvider {
    private let API: PKMainAPI
    
    init(API: PKMainAPI) {
        self.API = API
    }
    
    func fetchViewsData(
        completion: @escaping (Result<PKViewsDataResponseEntity, Error>) -> Void
    ) {
        API.viewsData(
            completion: { result in
                switch result {
                case .success(let responseEntity):
                    completion(.success(responseEntity))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}
