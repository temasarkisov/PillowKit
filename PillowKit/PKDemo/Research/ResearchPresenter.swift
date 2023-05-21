import UIKit

private let logger: Logger = Logger()

protocol ResearchPresenterDelegate: AnyObject {
    func updateContainer(_ container: PKContainer)
}

final class ResearchPresenter {
    private let view: ResearchPresenterDelegate
    private let handler: PKHandler
    
    init(
        view: ResearchPresenterDelegate,
        handler: PKHandler
    ) {
        self.view = view
        self.handler = handler
    }
}

extension ResearchPresenter: ResearchViewDelegate {
    func didLoad() {
        handler.buildContainer(
            endpoint: PKEndpoint(url: "/update_research_views_data"),
            completion: { [weak self] result in
                guard let this = self else {
                    return
                }
                switch result {
                case .success(let container):
                    this.view.updateContainer(container)
                case .failure(let error):
                    logger.log("Error: \(error)")
                }
            }
        )
    }
}
