import SwiftUI

struct HomeView: View {
    var body: some View {
		TabView {
			SearchView()
				.tabItem {
					Image.magnifyingGlass
					Text("Search")
				}

			Text("Trips View")
				.tabItem {
					Image.clockArrow
					Text("Trips")
				}

			Text("Inbox View")
				.tabItem {
					Image.chat
					Text("Inbox")
				}

			Text("Profile View")
				.tabItem {
					Image.person
					Text("Profile")
				}
		}.accentColor(.black)
    }
}

#Preview {
    HomeView()
}
