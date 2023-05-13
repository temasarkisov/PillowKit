import UIKit

final class PKContainerBuilder {
    private let provider: PKProvider = PKProvider(
        API: DefaultPKMainAPI(
            networkService: DefaultHTTPNetworkService()
        )
    )
    
    private let viewBuilder: PKViewBuilder = PKViewBuilder()
    
    private var container: PKContainer = PKContainer()
}

extension PKContainerBuilder {
    func build(
        completion: @escaping(Result<PKContainer, Error>) -> Void
    ) {
        provider.fetchViewsData(
            completion: { [weak self] result in
                guard let this = self else { return }
                
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
    
    private func compose(viewsData: PKViewsData) {
        viewsData.viewsRules.forEach { viewRules in
            addView(viewRules: viewRules)
        }
    }
    
    private func addView(viewRules: PKViewRules) {
        guard let view = viewBuilder.build(viewRules: viewRules) else {
            print("failed")
            return
        }
//        viewWrapper = PKViewWrapper(view: view, id: viewRules.id)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        container.addViewsConstraints(
            [
                view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                view.topAnchor.constraint(equalTo: container.topAnchor),
                view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            ]
        )
    }
}
