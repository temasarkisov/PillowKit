import Foundation


enum PKEndpoint: String {
    case viewsRules = "/update_views_rules"
}

extension PKEndpoint {
    var absolutePath: String {
        PKSecret.host + self.rawValue
    }
}
