import UIKit

protocol SignInViewDelegate: AnyObject {
    func didLoad()
    
    func didTapSignInButton()
}

class SignInViewController: UIViewController {
    private lazy var delegate: SignInViewDelegate = SignInPresenter(
        view: self,
        handler: PKHandler.shared
    )
    
    private var container: PKContainer?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        delegate.didLoad()
    }
}

extension SignInViewController: SignInPresenterDelegate {
    func updateContainer(_ container: PKContainer) {
        self.container?.removeFromSuperview()
        self.container = container
        
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            container.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            container.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            container.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
        ])
        
        guard let signUpButton = container.obtainView(by: "sign_up_button") as? PKButton else {
            return
        }
        signUpButton.setTapAction(tapAction: { [weak self] in
            self?.delegate.didTapSignInButton()
        })
    }
    
    func present(viewController: UIViewController) {
        navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
}
