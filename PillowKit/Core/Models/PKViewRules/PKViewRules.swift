import UIKit

struct PKViewRules {
    let id: String
    let name: Name
    let layout: [String: String]
    let visualProperties: [VisualPropertyName: String]
    let visualEffects: [String: String]?
    
    init(responseEntity: PKViewRulesResponseEntity) {
        id = responseEntity.id
        name = Name(rawValue: responseEntity.name) ?? .unknown
        layout = responseEntity.layout
        visualProperties = VisualPropertyName.serialize(
            responseEntity.visualProperties
        )
        visualEffects = nil
    }
}

extension PKViewRules {
    enum Name: String {
        case view = "PKView"
        case textField = "PKTextField"
        case imageView = "PKImageView"
        case unknown
    }
    
    enum VisualPropertyName: String {
        case backgroundColor = "backgorund_color"
        case cornerRadius = "corner_radius"
        case unknown
        
        fileprivate static func serialize(
            _ visualProperties: [String: String]
        ) -> [VisualPropertyName: String] {
            visualProperties.reduce(into: [:]) { partialResult, visualProperty in
                partialResult[VisualPropertyName(rawValue: visualProperty.key) ?? .unknown] = visualProperty.value
            }
        }
    }
}
