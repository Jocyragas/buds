import SwiftUI

struct BottomSheetView<Content: View>: View  {
	
	@Binding var title: String
	@Binding var headerSheetType: headerSheetTypes
	@State private var contentMaxHeight: CGFloat = 0
	private let extraHeightLimits: CGFloat = 20
	@State private var contentHeight: CGFloat = 0
	@State var bottomSheetHeight: CGFloat = 100
	let minimumHeight: CGFloat
	var snapPoints: [CGFloat]?
	let content: Content
	
	
	init(bottomSheetHeight: CGFloat,
		 minimumHeight:CGFloat,
		 headerSheetType: Binding<headerSheetTypes>,
		 title: Binding<String>,
		 snapPoints: [CGFloat]?,
		 @ViewBuilder content: () -> Content){
		self.minimumHeight = minimumHeight
		self.content = content()
		self._headerSheetType = headerSheetType
		self._title = title
		self.snapPoints = snapPoints
		self.bottomSheetHeight = bottomSheetHeight
		
	}
	
	var body: some View {
		GeometryReader { geometry in
			let maxScreenHeight = geometry.size.height - geometry.safeAreaInsets.top
			let isScrollable = contentHeight > maxScreenHeight
			
			VStack(spacing: 0) {
				VStack(spacing: 16) {
					Color.gray.frame(width: 44, height: 4)
						.cornerRadius(2, corners: .allCorners)
					Group {
						if headerSheetType == .grayBarTitleCentered {
							Text(title)
								.font(.customFont(.muliBold, size: 20))
							Color.gray.opacity(0.1).frame(height: 1)
						} else {
							HStack {
								Spacer().frame(width: 34)
								Text("Arriving in 7 mins")
									.font(.customFont(.muliBold, size: 20))
								Spacer()
							}
						}
					}
				}
				.padding(.top, 8)
				.padding(.bottom, headerSheetType == .grayBarTitleCentered ? 0 : 14)
				.frame(maxWidth: .infinity)
				.background(Color.white)
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
	@State var title = "test"
	@State var bottomSheetType = headerSheetTypes.grayBarTitleCentered
	
	var body: some View {
		ZStack(alignment: .bottom) {
			VStack {
				Button("Button title") {
					title += " title"
					bottomSheetType = .grayBarTitleLeft
				}.buttonStyle(.primaryButton).frame(width: 300, height: 300)
				Spacer()
			}.frame(width: .infinity, height: .infinity)
			
			BottomSheetView(bottomSheetHeight: bottomSheetHeight,
							minimumHeight: minimumHeight,
							headerSheetType: $bottomSheetType,
							title: $title) {
				
				VStack(spacing:0) {
					Color.white.frame(width: 400, height: 400)
					Color.red.frame(width: 400, height: 3)
					Spacer().frame(height: 50)
				}
			}
		}
		
	}
}


#Preview {
	ContentView()
}

