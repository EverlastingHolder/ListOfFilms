import SwiftUI

@main
struct ListOfFilmsApp: App {
    @ObservedObject private var viewModel: FilmsList.ViewModel = .init()
    var body: some Scene {
        WindowGroup {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            case .success:
                NavigationView {
                    FilmsList(films: viewModel.films)
                        .navigationBarTitle(Text("Фильмы"), displayMode: .inline)
                }
            case .fail:
                ErrorView(action: {
                    viewModel.fetch()
                })
            }
        }
    }
}
