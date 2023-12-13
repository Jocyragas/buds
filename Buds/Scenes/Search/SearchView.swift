//
//  Search.swift
//  Buds
//
//  Created by Samuel Martins on 12/12/23.
//

import SwiftUI

struct SearchView: View {
	@State private var showingCredits = true

    var body: some View {
		VStack{
			
		}
			.sheet(isPresented: $showingCredits) {
				Text("This app was brought to you by Hacking with Swift")
					.presentationDetents([.height(300), .height(100), .large])
					.interactiveDismissDisabled()
			}
    }
}

#Preview {
	SearchView()
}
