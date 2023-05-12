import UIKit

private let logger: Logger = Logger()

protocol DemoPresenterDelegate: AnyObject {
    func updateContainer(_ container: PKContainer)
}

final class DemoPresenter {
    private let view: DemoPresenterDelegate
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
    func didLoad() {
        containerBuilder.build(
            completion: { [weak self] result in
                guard let this = self else { return }
                
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
