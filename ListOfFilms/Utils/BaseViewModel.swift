import Combine

class BaseViewModel {
    var bag: Set<AnyCancellable> = .init()
    deinit {
        self.bag.forEach { $0.cancel() }
        self.bag.removeAll()
    }
}
