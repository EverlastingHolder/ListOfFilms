import SwiftUI

struct ErrorView: View {
    var action: () -> Void
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 4) {
                Text("Что-то пошло не так")
                    .font(.headline)
                Text("Проверьте интернет соединение")
                    .font(.subheadline)
            }
            Button(action: action) {
                Text("Попробовать снова")
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
            .frame(height: 50)
            .background(Color.blue)
            .cornerRadius(12)
        }
    }
}
