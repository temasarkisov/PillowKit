import UIKit

struct PKViewRules {
    let id: String
    let viewType: ViewType
    let layoutConfig: [LayoutConfigKey: String]
    let visualProperties: [VisualPropertyKey: String]
    let visualEffects: [String: String]?
}

extension PKViewRules {
    init(_ viewRulesResponseEntity: PKViewRulesResponseEntity) {
        id = viewRulesResponseEntity.id
        viewType = ViewType(rawValue: viewRulesResponseEntity.viewType) ?? .unknown
        layoutConfig = LayoutConfigKey.serialize(
            viewRulesResponseEntity.layoutConfig
        )
        visualProperties = VisualPropertyKey.serialize(
            viewRulesResponseEntity.visualProperties
        )
        visualEffects = nil
    }
}

extension PKViewRules {
    enum ViewType: String {
        case view = "UIView"
        case textField = "UITextField"
        case imageView = "UIImageView"
        case unknown
    }
    
    enum LayoutConfigKey: String {
        case left = "left"
        case top = "top"
        case right = "right"
        case bottom = "bottom"
        case centerX = "centerX"
        case centerY = "centerY"
        case unknown
        
        fileprivate static func serialize(
            _ layoutConfig: [String: String]
        ) -> [LayoutConfigKey: String] {
            layoutConfig.reduce(into: [:]) { partialResult, layoutConfigItem in
                partialResult[LayoutConfigKey(rawValue: layoutConfigItem.key) ?? .unknown] = layoutConfigItem.value
            }
        }
    }
    
    enum VisualPropertyKey: String {
        case backgroundColor = "background_color"
        case cornerRadius = "corner_radius"
        case unknown
        
        fileprivate static func serialize(
            _ visualProperties: [String: String]
        ) -> [VisualPropertyKey: String] {
            visualProperties.reduce(into: [:]) { partialResult, visualProperty in
                partialResult[VisualPropertyKey(rawValue: visualProperty.key) ?? .unknown] = visualProperty.value
            }
        }
    }
}
