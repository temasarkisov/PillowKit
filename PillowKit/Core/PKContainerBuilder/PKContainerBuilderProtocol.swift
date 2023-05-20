import UIKit

protocol PKContainerBuilderProtocol: AnyObject {
    func build(viewsData: PKViewsData) -> PKContainer
}
