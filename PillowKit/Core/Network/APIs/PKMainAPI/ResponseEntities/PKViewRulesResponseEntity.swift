import Foundation

public struct PKViewRulesResponseEntity: Identifiable, Codable {
    public let id: String
    public let name: String
    public let layout: [String: String]
    public let visualProperties: [String: String]
    public let visualEffects: [String: String]?
}
