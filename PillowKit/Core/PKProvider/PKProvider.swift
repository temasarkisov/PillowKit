import UIKit

final class PKProvider {
    private let API: PKMainAPI
    
    init(API: PKMainAPI) {
        self.API = API
    }
    
    func fetchViewsData(
        completion: @escaping (Result<PKViewsData, Error>) -> Void
    ) {
        API.viewsData(
            completion: { result in
                switch result {
                case .success(let viewsDataResponseEntity):
                    completion(.success(PKViewsData(viewsDataResponseEntity)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}
