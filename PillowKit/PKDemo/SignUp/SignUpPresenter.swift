import UIKit

private let logger: Logger = Logger()

protocol SignUpPresenterDelegate: AnyObject {
    func updateContainer(_ container: PKContainer)
    
    func present(viewController: UIViewController)
}

final class SignUpPresenter {
    private let view: SignUpPresenterDelegate
    private let handler: PKHandler
    
    init(
        view: SignUpPresenterDelegate,
        handler: PKHandler
    ) {
        self.view = view
        self.handler = handler
    }
}

extension SignUpPresenter: SignUpViewDelegate {
    func didLoad() {
        handler.buildContainer(
            endpoint: PKEndpoint(url: "/update/views/data"),
            viewsDataName: "sign_up_views_data",
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
    
    func didTapContinueButton() {
        view.present(viewController: SignInViewController())
    }
}
