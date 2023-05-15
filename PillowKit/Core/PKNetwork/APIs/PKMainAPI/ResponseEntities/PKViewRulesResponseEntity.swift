import Foundation

public struct PKViewRulesResponseEntity: Identifiable, Codable {
    public let id: String
    public let viewType: String
    public let layoutConfig: [String: [String: String]]
    public let visualProperties: [String: String]?
    public let visualEffects: [String: String]?
}
