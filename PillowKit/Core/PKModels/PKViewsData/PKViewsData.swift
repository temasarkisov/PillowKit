import UIKit

struct PKViewsData {
    let viewsRules: [PKViewRules]
}

extension PKViewsData {
    init(_ viewsDataResponseEntity: PKViewsDataResponseEntity) {
        viewsRules = viewsDataResponseEntity.viewsRules.map { viewRulesResponseEntity in
            PKViewRules(viewRulesResponseEntity)
        }
    }
}
