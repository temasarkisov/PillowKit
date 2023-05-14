import UIKit

protocol PKViewBuilderProtocol: AnyObject {
    func build(viewRules: PKViewRules) -> PKView?
}
