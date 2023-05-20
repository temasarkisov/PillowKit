import UIKit

final class PKContainerBuilder: PKContainerBuilderProtocol {
    private let viewWrapperBuilder: PKViewWrapperBuilderProtocol
    
    init(
        viewWrapperBuilder: PKViewWrapperBuilderProtocol
    ) {
        self.viewWrapperBuilder = viewWrapperBuilder
    }
}

extension PKContainerBuilder {
    func build(viewsData: PKViewsData) -> PKContainer {
        let container = PKContainer()
        viewsData.viewsRules.forEach { viewRules in
            guard let viewWrapper = viewWrapperBuilder.build(
                viewRules: viewRules
            ) else {
                return
            }
            container.addViewWrapper(viewWrapper: viewWrapper)
        }
        container.calculateConstraints()
        
        return container
    }
}
