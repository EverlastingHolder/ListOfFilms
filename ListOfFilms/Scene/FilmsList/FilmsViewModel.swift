import Foundation
import SwiftUI

extension FilmsList {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.filmsService) var service
        @Published var films: [Int: [Film]] = [:]
        @Published var state: StateView = .fail
        
        override init() {
            super.init()
            fetch()
        }
        
        func fetch() {
            state = .loading
            service.fetchFilms()
                .subscribe(on: Scheduler.background)
                .receive(on: Scheduler.main)
                .sink(receiveCompletion: { [self] (completion) in
                    switch completion {
                    case .failure(_):
                        state = .fail
                    case .finished:
                        state = .success
                    }
                }){ [self] result in
                    films = Dictionary(grouping: result.films) {
                        $0.year
                    }
                }
                .store(in: &self.bag)
        }
    }
}
