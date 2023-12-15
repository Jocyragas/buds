import SwiftUI

struct HomeView: View {
	init() {
//	   UITabBar.appearance().backgroundColor = UIColor.white
	 }
	
    var body: some View {
		TabView {
			ContentView()
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
