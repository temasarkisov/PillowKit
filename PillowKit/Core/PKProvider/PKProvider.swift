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
                    let startForRulesProc = NSDate()  // Code for research
                    PKViewsData(viewsDataResponseEntity)
                    let endForRulesProc = NSDate()  // Code for research
                    let timeIntervalForRulesProc: Double = endForRulesProc.timeIntervalSince(startForRulesProc as Date)  // Code for research
                    print("Elapsed time to process rules = \(timeIntervalForRulesProc)") // Code for research
                    completion(.success(PKViewsData(viewsDataResponseEntity)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}
