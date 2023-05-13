import UIKit

struct PKViewRules {
    let id: String
    let viewType: ViewType
    let layoutConfig: [LayoutConfigKey: String]
    let visualProperties: [VisualPropertyKey: String]
    let visualEffects: [VisualEffectKey: String]
}

extension PKViewRules {
    init(_ responseEntity: PKViewRulesResponseEntity) {
        id = responseEntity.id
        viewType = ViewType(rawValue: responseEntity.viewType) ?? .unknown
        layoutConfig = LayoutConfigKey.serialize(responseEntity.layoutConfig)
        visualProperties = VisualPropertyKey.serialize(responseEntity.visualProperties)
        visualEffects = VisualEffectKey.serialize(responseEntity.visualEffects)
    }
}

extension PKViewRules {
    enum ViewType: String {
        case label = "label"
        case image = "image"
        case textField = "text_field"
        case button = "button"
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
        case borderColor = "border_color"
        case borderWidth = "border_width"
        
        case text = "text"
        case font = "font"
        case fontSize = "font_size"
        case textColor = "text_color"
        case textAlignment = "text_alignment"
        
        case imageURL = "image_URL"
        
        case placeholder = "placeholder"
        
        case autocorrectionType = "autocorrection_type"
        case autocapitalizationType = "autocapitalization_type"
        
        case isUserInteractionEnabled = "is_user_interaction_enabled"
        
        case unknown
        
        fileprivate static func serialize(
            _ visualProperties: [String: String]?
        ) -> [VisualPropertyKey: String] {
            guard let visualProperties = visualProperties else {
                return [:]
            }
            return visualProperties.reduce(into: [:]) { partialResult, visualProperty in
                partialResult[VisualPropertyKey(rawValue: visualProperty.key) ?? .unknown] = visualProperty.value
            }
        }
    }
    
    enum VisualEffectKey: String {
        case tapEffect = "tap_effect"
        case unknown
        
        fileprivate static func serialize(
            _ visualEffects: [String: String]?
        ) -> [VisualEffectKey: String] {
            guard let visualEffects = visualEffects else {
                return [:]
            }
            return visualEffects.reduce(into: [:]) { partialResult, visualEffect in
                partialResult[VisualEffectKey(rawValue: visualEffect.key) ?? .unknown] = visualEffect.value
            }
        }
    }
}
