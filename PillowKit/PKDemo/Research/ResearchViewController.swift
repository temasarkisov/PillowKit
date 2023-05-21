import UIKit

protocol ResearchViewDelegate: AnyObject {
    func didLoad()
}

class ResearchViewController: UIViewController {
    private lazy var delegate: ResearchViewDelegate = ResearchPresenter(
        view: self,
        handler: PKHandler.shared
    )
    
    private var container: PKContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate.didLoad()
    }
}

extension ResearchViewController: ResearchPresenterDelegate {
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
    }
}
