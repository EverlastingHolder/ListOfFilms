import Foundation

extension URLRequest {
    init (
        _ url: URL,
        method: String
    ) {
        self.init(url: url)
        self.httpMethod = method
    }
}
