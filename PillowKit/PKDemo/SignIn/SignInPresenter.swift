import UIKit

private let logger: Logger = Logger()

protocol SignInPresenterDelegate: AnyObject {
    func updateContainer(_ container: PKContainer)
    
    func present(viewController: UIViewController)
}

final class SignInPresenter {
    private let view: SignInPresenterDelegate
    private let handler: PKHandler
    
    init(
        view: SignInPresenterDelegate,
        handler: PKHandler
    ) {
        self.view = view
        self.handler = handler
    }
}

extension SignInPresenter: SignInViewDelegate {
    func didLoad() {
        handler.buildContainer(
            endpoint: PKEndpoint(url: "/update_sign_in_views_data"),
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
    
    func didTapSignInButton() {
        view.present(viewController: SignUpViewController())
    }
}
