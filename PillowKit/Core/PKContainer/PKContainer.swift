import UIKit

final class PKContainer: UIView {
    private var viewsConstraints: [NSLayoutConstraint] = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate(viewsConstraints)
    }
}

extension PKContainer {
    func addViewsConstraints(_ constraints: [NSLayoutConstraint]) {
        viewsConstraints.append(contentsOf: constraints)
    }
}
