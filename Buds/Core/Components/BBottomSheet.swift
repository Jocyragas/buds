import SwiftUI

struct BottomSheetView<Content: View>: View  {
	
	@State private var contentMaxHeight: CGFloat = 0
	private let extraHeightLimits: CGFloat = 20
	@State private var contentHeight: CGFloat = 0

	@State var bottomSheetHeight: CGFloat = 100
	let minimumHeight: CGFloat
	let snapPoints: [CGFloat] = [100, 300]
	let content: Content
	
	init(bottomSheetHeight: CGFloat, minimumHeight:CGFloat, @ViewBuilder content: () -> Content) {
		self.minimumHeight = minimumHeight
		self.content = content()
		self.bottomSheetHeight = bottomSheetHeight
	}
	
	
	// Define your snap points based on your needs
	
	var body: some View {
		GeometryReader { geometry in
			let maxScreenHeight = geometry.size.height - geometry.safeAreaInsets.top
			let isScrollable = contentHeight > maxScreenHeight
			
			VStack {
				Text("Drag Me")
					.frame(maxWidth: .infinity)
					.frame(height: 50)
					.background(Color.gray)
					.cornerRadius(10, corners: [.topLeft, .topRight])
					.shadow(color: .gray, radius: 5, x: 0, y: 0)
					.mask(Rectangle().padding(.top, -20))
					.gesture(
						DragGesture()
							.onChanged{ value in
								bottomSheetHeight = calculateHeight(
									translation: value.translation.height, 
									maxScreenHeight: maxScreenHeight,
									hasExtraValues: true
								)
							}
							.onEnded { value in
								withAnimation(.spring()) {
									bottomSheetHeight = calculateHeight(
										translation: value.translation.height,
										maxScreenHeight: maxScreenHeight,
										hasExtraValues: false
									)
								}
							}
					)
				Group {
					if isScrollable {
						ScrollView {
							content.measureSize(contentHeight: $contentHeight)
						}
					} else {
						content.measureSize(contentHeight: $contentHeight)
					}
				}
			}
			.background(.white)
			.frame(width: UIScreen.main.bounds.width, height: bottomSheetHeight)
			.offset(y: geometry.size.height - bottomSheetHeight)
//			.animation(.interactiveSpring(), value: 20)
		}
	}
	
	private func calculateHeight(translation: CGFloat, maxScreenHeight: CGFloat, hasExtraValues: Bool) -> CGFloat {
		let extraLimits = hasExtraValues ? extraHeightLimits : 0
		contentMaxHeight = self.contentHeight > maxScreenHeight ? maxScreenHeight : self.contentHeight
		var proposedHeight = bottomSheetHeight - translation
		proposedHeight = min(proposedHeight, contentMaxHeight + extraLimits)
		proposedHeight = max(proposedHeight, minimumHeight - extraLimits)
		return proposedHeight
	}
	
	// Function to find the closest snap point
	private func snapToClosest(_ height: CGFloat, snapPoints: [CGFloat]) -> CGFloat {
		var closest = snapPoints.min(by: { abs($0 - height) < abs($1 - height) })
		closest = min(closest!, height)
		return closest!
	}
}

struct ContentView: View {
	private var bottomSheetHeight: CGFloat = 300
	private var minimumHeight: CGFloat = 100
	
	var body: some View {
		ZStack(alignment: .bottom) {
			VStack {
				Button("Button title") {
					print("Button tapped!")
				}.buttonStyle(.primaryButton).frame(width: 300, height: 300)
				Spacer()
			}.frame(width: .infinity, height: .infinity)

			BottomSheetView(bottomSheetHeight: bottomSheetHeight,
							minimumHeight: minimumHeight) {
				
				VStack {
					Color.blue.frame(width: 400, height: 400)
				}
			}
		}
		
	}
}


#Preview {
	ContentView()
}

