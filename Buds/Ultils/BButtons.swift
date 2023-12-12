
import SwiftUI

extension ButtonStyle where Self == PrimaryButtonStyle {
	
	public static var primaryButton: some ButtonStyle { PrimaryButtonStyle() }
}

extension ButtonStyle where Self == SecondaryButtonStyle {
	
	public static var secondaryButton: Self { SecondaryButtonStyle() }
}

public struct PrimaryButtonStyle: ButtonStyle {
	@Environment(\.isEnabled) var isEnabled
	
	public func makeBody(configuration: Configuration) -> some View {
		var backgroundColor: Color = .disableGrayBackground
		
		if isEnabled {
			backgroundColor = configuration.isPressed ? Color.mediumPurple : Color.lightPurple
		}
		
		return configuration.label
			.padding()
			.background(backgroundColor) // Choose your fill color
			.font(.customFont(.muliBold, size: 20))
			.foregroundColor(.white) // Choose your text color
			.clipShape(RoundedRectangle(cornerRadius: 30)) // Set the corner radius
			.scaleEffect(configuration.isPressed ? 0.95 : 1)
	}
}

public struct SecondaryButtonStyle: ButtonStyle {
	@Environment(\.isEnabled) var isEnabled
	
	public func makeBody(configuration: Configuration) -> some View {
		var backgroundColor: Color = .disableGrayBackground
		var foregroundColor: Color = .disableGrayForeground
		var borderWidth: CGFloat = 0
		
		if isEnabled {
			backgroundColor = configuration.isPressed ? Color.mediumPurple : Color.white
			foregroundColor = configuration.isPressed ? .white : .black
			borderWidth = configuration.isPressed ? 0.95 : 1
		}
		
		return configuration.label
			.padding()
			.background(backgroundColor) // Choose your fill color
			.font(.customFont(.muliBold, size: 20))
			.foregroundColor(foregroundColor) // Choose your text color
			.clipShape(RoundedRectangle(cornerRadius: 30)) // Set the corner radius
			.overlay(
				RoundedRectangle(cornerRadius: 30)
					.stroke(.grayBorder, lineWidth: borderWidth)
			)
			.scaleEffect(configuration.isPressed ? 0.95 : 1)
	}
}


struct ButtonsView: View {
	var body: some View {
		
		Button("New Button") {}
			.disabled(false)
			.buttonStyle(.primaryButton)
		
		Button("New Button") {}
			.buttonStyle(.secondaryButton)
	}
}


#Preview {
	ButtonsView()
}
