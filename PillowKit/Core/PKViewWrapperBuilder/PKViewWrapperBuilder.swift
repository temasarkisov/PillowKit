import UIKit

final class PKViewWrapperBuilder: PKViewWrapperBuilderProtocol {
    private let viewBuilder: PKViewBuilderProtocol
    
    init(
        viewBuilder: PKViewBuilderProtocol
    ) {
        self.viewBuilder = viewBuilder
    }
}

extension PKViewWrapperBuilder {
    func build(viewRules: PKViewRules) -> PKViewWrapper? {
        guard let view = viewBuilder.build(viewRules: viewRules) else {
            return nil
        }
        
        let viewWrapper = PKViewWrapper(
            view: view,
            viewID: viewRules.id,
            viewLayoutConfig: viewRules.layoutConfig
        )
        
        return viewWrapper
    }
}
