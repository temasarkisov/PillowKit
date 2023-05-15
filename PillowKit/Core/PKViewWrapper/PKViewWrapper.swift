import UIKit

struct PKViewWrapper {
    let view: PKView
    let viewID: String
    let viewLayoutConfig: [PKViewRules.AnchorName: [String: String]]
    
    init(
        view: PKView,
        viewID: String,
        viewLayoutConfig: [PKViewRules.AnchorName: [String: String]]
    ) {
        self.viewID = viewID
        self.view = view
        self.viewLayoutConfig = viewLayoutConfig
    }
}
