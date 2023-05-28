import UIKit

final class PKHandler: PKHandlerProtocol {
    static let shared = PKHandler()
    
    private let provider: PKProvider = PKProvider(
        API: DefaultPKMainAPI(
            networkService: DefaultHTTPNetworkService()
        )
    )
    private let containerBuilder: PKContainerBuilderProtocol = PKContainerBuilder(
        viewWrapperBuilder: PKViewWrapperBuilder(
            viewBuilder: PKViewBuilder()
        )
    )
    private var container: PKContainer = PKContainer()
    
    private init() {}
}

extension PKHandler {
    func buildContainer(
        endpoint: PKEndpoint,
        viewsDataName: String,
        completion: @escaping(Result<PKContainer, Error>) -> Void
    ) {
        provider.fetchViewsData(
            endpoint: endpoint,
            viewsDataName: viewsDataName,
            completion: { [weak self] result in
                guard let this = self else {
                    return
                }
                switch result {
                case .success(let viewsData):
                    let start = NSDate()  // Code for research
                    this.container = this.containerBuilder.build(viewsData: viewsData)
                    let end = NSDate()  // Code for research
                    let timeInterval: Double = end.timeIntervalSince(start as Date)  // Code for research
                    print("Elapsed time to build container = \(timeInterval)") // Code for research
                    completion(.success(this.container))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}

extension PKHandler {
    func obtainContainer() -> PKContainer {
        container
    }
    
    func obtainView(by viewID: String) -> PKView? {
        container.obtainView(by: viewID)
    }
}
