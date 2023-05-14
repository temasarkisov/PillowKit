import UIKit

protocol PKViewWrapperBuilderProtocol: AnyObject {
    func build(viewRules: PKViewRules) -> PKViewWrapper?
}
