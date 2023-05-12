import UIKit

protocol DemoViewDelegate: AnyObject {
    func didLoad()
}

class DemoViewController: UIViewController {
    private lazy var delegate: DemoViewDelegate = DemoPresenter(
        view: self,
        containerBuilder: PKContainerBuilder()
    )
    
    private var container: PKContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate.didLoad()
    }
}

extension DemoViewController: DemoPresenterDelegate {
    func updateContainer(_ container: PKContainer) {
        self.container?.removeFromSuperview()
        self.container = container
        
        container.translatesAutoresizingMaskIntoConstraints = false
        
        print(#function, container.subviews)
        
        view.addSubview(container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            container.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            container.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            container.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
        ])
    }
}