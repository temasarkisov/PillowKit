import UIKit

protocol PKContainerBuilderProtocol: AnyObject {
    func build(completion: @escaping(Result<PKContainer, Error>) -> Void)
}
