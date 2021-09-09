import SwiftUI
import SDWebImageSwiftUI

struct DetailFilmView: View {
    @State var film: Film
    @ObservedObject var viewModel: Self.ViewModel = .init()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        if viewModel.isError {
                            Image("notFound")
                                .resizable()
                                .frame(width: 150, height: 100)
                        } else {
                            WebImage(url: URL(string: film.image_url ?? ""))
                                .resizable()
                                .onFailure { _ in
                                    viewModel.isError = true
                                }
                                .placeholder {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                }
                                .frame(width: 200, height: 200)
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text(film.name)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Год: \(film.year)")
                        Text("Рейтинг: ") + Text(film.rating?.description ?? "Не указан")
                            .foregroundColor(ratingColor(rating: film.rating ?? 0))
                    }
                }.padding()
                Text(film.description ?? "")
                    .padding()
            }
        }.navigationTitle(film.localized_name)
    }
}
