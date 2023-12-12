//
//  ContentView.swift
//  Buds
//
//  Created by Samuel Martins on 11/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
			Text("Hello, world!").underline(color: .budsRed)
        }
        .padding()

    }
}

#Preview {
    ContentView()
}
