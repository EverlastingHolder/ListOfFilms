import Foundation
import SwiftUI
import Combine

protocol FilmsServiceType {
    func fetchFilms () -> AnyPublisher<Films, Error>
}

final class FilmsService: FilmsServiceType {
    @Environment(\.agent)
    var agent: Agent
    
    func fetchFilms() -> AnyPublisher<Films, Error> {
        self.agent.run()
    }
}

struct FilmsServiceKey: EnvironmentKey {
    static let defaultValue: FilmsService = FilmsService()
}

extension EnvironmentValues {
    var filmsService: FilmsService {
        get {
            self[FilmsServiceKey.self]
        }
        set {
            self[FilmsServiceKey.self] = newValue
        }
    }
}
