import Foundation

struct Logger {
    func log(_ text: String) {
        print("[DEBUG] \(text)")
    }
    
    func error(_ text: String) {
        print("[DEBUG] Error: \(text)")
    }
}
