import SwiftUI

enum FontTypes: String {
	
	case muli = "Muli"
	case muliLight = "Muli-Light"
	case muliSemiBold = "Muli-SemiBold"
	case muliBold = "Muli-Bold"
}

extension Font {
	
	static func customFont(_ type: FontTypes, size: CGFloat) -> Font {
		return Font.custom(type.rawValue, size: size)
	}
}
