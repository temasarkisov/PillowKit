import UIKit

final class PKContainerBuilder: PKContainerBuilderProtocol {
    private let provider: PKProvider = PKProvider(
        API: DefaultPKMainAPI(
            networkService: DefaultHTTPNetworkService()
        )
    )
    private let viewWrapperBuilder: PKViewWrapperBuilderProtocol = PKViewWrapperBuilder(
        viewBuilder: PKViewBuilder()
    )
    private var container: PKContainer = PKContainer()
}

extension PKContainerBuilder {
    func build(completion: @escaping(Result<PKContainer, Error>) -> Void) {
        provider.fetchViewsData(
            completion: { [weak self] result in
                guard let this = self else {
                    return
                }
                switch result {
                case .success(let viewsData):
                    this.compose(viewsData: viewsData)
                    completion(.success(this.container))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}
    
extension PKContainerBuilder {
    private func compose(viewsData: PKViewsData) {
        viewsData.viewsRules.forEach { viewRules in
            addViewWrapper(viewRules: viewRules)
        }
        container.calculateConstraints()
    }
    
    private func addViewWrapper(viewRules: PKViewRules) {
        guard let viewWrapper = viewWrapperBuilder.build(
            viewRules: viewRules
        ) else {
            return
        }
        container.addViewWrapper(viewWrapper: viewWrapper)
    }
}
