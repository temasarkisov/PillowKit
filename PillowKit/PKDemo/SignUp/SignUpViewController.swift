import UIKit

protocol SignUpViewDelegate: AnyObject {
    func didLoad()
    
    func didTapContinueButton()
}

class SignUpViewController: UIViewController {
    private lazy var delegate: SignUpViewDelegate = SignUpPresenter(
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

extension SignUpViewController: SignUpPresenterDelegate {
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
        
        guard let continueButton = container.obtainView(by: "continue_button") as? PKButton else {
            return
        }
        continueButton.setTapAction(tapAction: { [weak self] in
            self?.delegate.didTapContinueButton()
        })
    }
    
    func present(viewController: UIViewController) {
        navigationController?.popViewController(animated: true)
    }
}
