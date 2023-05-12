import UIKit

private let logger: Logger = Logger()

protocol DemoPresenterDelegate: AnyObject {
    func updateContainer(_ container: PKContainer)
}

final class DemoPresenter {
    weak var view: DemoPresenterDelegate?
    private let containerBuilder: PKContainerBuilder
    
    init(
        view: DemoPresenterDelegate,
        containerBuilder: PKContainerBuilder
    ) {
        self.view = view
        self.containerBuilder = containerBuilder
    }
}

extension DemoPresenter: DemoViewDelegate {
    func didLoad(view: DemoViewController) {
        containerBuilder.build(
            completion: { [weak self] result in
                guard let this = self else { return }
                
                switch result {
                case .success(let container):
                    view.updateContainer(container)
                case .failure(let error):
                    logger.log("Error: \(error)")
                }
            }
        )
    }
}
