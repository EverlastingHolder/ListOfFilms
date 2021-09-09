import Foundation
import Combine
import SwiftUI

class Agent {
    private let session: URLSession = .shared
    
    private let base: URL = URL(string: "https://s3-eu-west-1.amazonaws.com/sequeniatesttask/films.json")!
    
    func run<T: Codable> (
        method: String = "GET",
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<T, Error> {
        let request = URLRequest.init(
            self.base,
            method: method
        )
        return self.request(request)
    }
    
    private func request<T: Codable> (_ request: URLRequest) -> AnyPublisher<T, Error> {
        return self.session
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .subscribe(on: Scheduler.background)
            .receive(on: Scheduler.main)
            .share()
            .eraseToAnyPublisher()
    }
}

struct AgentKey: EnvironmentKey {
    static let defaultValue: Agent = Agent()
}

extension EnvironmentValues {
    var agent: Agent {
        get {
            self[AgentKey.self]
        }
        set {
            self[AgentKey.self] = newValue
        }
    }
}
