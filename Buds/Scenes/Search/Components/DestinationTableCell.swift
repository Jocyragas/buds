//
//  DestinationTableCell.swift
//  Buds
//
//  Created by Samuel Martins on 22/12/23.
//

import SwiftUI

struct DestinationTableCell: View {

	let title: String
	let subtitle: String
	
    var body: some View {
		HStack {
			Image.icnLocalization
				.resizable()
				.scaledToFill()
				.frame(width: 18, height: 20)
			Spacer().frame(width: 20)
			VStack(alignment: .leading) {
				Text(title)
					.font(.customFont(.muliBold, size: 16))
				Text(subtitle)
					.font(.customFont(.muliLight, size: 16))
			}
		}
    }
}

#Preview {
	DestinationTableCell(
		title: "Village",
		subtitle: "3400 Poly Vista, Pomona"
	)
}
