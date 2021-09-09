import SwiftUI

struct FilmsList: View {
    @State var films: [Int: [Film]]
    var body: some View {
        List {
            ForEach(films.sorted(by: {
                $0.key < $1.key
            }), id: \.key) { year, films in
                Section(header: Text(year.description)) {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(films.sorted(by: { $0.rating ?? 0 > $1.rating ?? 0 }), id: \.id) { film in
                            NavigationLink(destination: DetailFilmView(film: film)) {
                                HStack(alignment: .top) {
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text(film.localized_name)
                                            .font(.headline)
                                        Text(film.name)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }.padding([.vertical, .leading], 12)
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        Text("\(film.rating?.description ?? "")")
                                            .foregroundColor(ratingColor(rating: film.rating ?? 0))
                                    }.padding([.top, .trailing], 12)
                                }
                                .background(Color.init(hex: "#D0E2F3"))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke()
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}
