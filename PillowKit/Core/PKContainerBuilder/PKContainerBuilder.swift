import UIKit

private let logger: Logger = Logger()

final class PKViewContainerBuilder {
    private let provider: PKProvider = PKProvider(
        API: DefaultPKMainAPI(
            networkService: DefaultHTTPNetworkService()
        )
    )
    private let viewsBuilder: PKViewsBuilder = PKViewsBuilder()
    
//    init(
//        provider: PKProvider,
//        viewsFactory: PKViewsFactory
//    ) {
//        self.provider = provider
//        self.viewsFactory = viewsFactory
//    }
}

extension PKViewContainerBuilder {
    func build(
        completion: @escaping(Result<UIView, Error>) -> Void
    ) {
        provider.fetchViewsData(
            completion: { [weak self] result in
                guard let this = self else { return }
                
                switch result {
                case .success(let viewsData):
                    
                case .failure(let error):
                    logger.log("Error: \(error)")
                }
            }
        )
    }
    
    func build(viewRules: PKViewRules) -> UIView {
        
    }
}
