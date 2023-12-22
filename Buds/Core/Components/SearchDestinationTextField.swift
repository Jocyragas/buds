
import SwiftUI

struct SimpleDestinationTextField: View {
	@Binding var searchText: String

	var body: some View {
		HStack {
			Image.magnifyingGlass
				.imageScale(.large)
				.frame(width: 16, height: 16)
				.foregroundColor(.lightPurple)
			Spacer().frame(width: 18)
			TextField("Search destination", text: $searchText)
				.foregroundColor(.bPlaceholderGray)
				.font(.customFont(.muliLight, size: 16))
				.disabled(true)

			if !searchText.isEmpty {
				Button(action: {
					searchText = ""
				}) {
					Image(systemName: "xmark.circle.fill")
						.foregroundColor(.gray)
				}
			}
		}
		.padding(.all, 20)
		.background()
		.cornerRadius(8)
		.compositingGroup()
		.shadow(
			color: .black.opacity(0.16),
			radius: 8, x: 2, y: 3
		)
	}
}

struct SearchDestinationTextField: View {
	@State private var text = ""

	var body: some View {
		SimpleDestinationTextField(searchText: $text)
	}
}
#Preview {
    SearchDestinationTextField()
}
