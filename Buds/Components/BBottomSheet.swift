import SwiftUI

struct ContentView: View {
	@State private var bottomSheetHeight: CGFloat = 300 // Initial height of the bottom sheet
	@State private var dragOffset: CGFloat = 0
	@State private var minimumHeight: CGFloat = 100
	
	var body: some View {
		ZStack(alignment: .bottom) {
			// Main content view
			// ...
			Spacer().background(.red).frame()
			// Bottom sheet view
			BottomSheetView(
				bottomSheetHeight: $bottomSheetHeight,
				dragOffset: $dragOffset,
				minimumHeight: $minimumHeight
			)
		}
		.edgesIgnoringSafeArea(.horizontal)
		
	}
}

struct BottomSheetView: View {
	@Binding var bottomSheetHeight: CGFloat
	@Binding var dragOffset: CGFloat
	@Binding var minimumHeight: CGFloat
	let extraHeightLimits: CGFloat = 20
	let snapPoints: [CGFloat] = [100, 600, 700]// Define your snap points based on your needs

	var body: some View {
		GeometryReader { geometry in
			let maxHeight = geometry.size.height - geometry.safeAreaInsets.top
			
			VStack {
				Text("Drag Me")
					.frame(maxWidth: .infinity)
					.frame(height: 50)
					.background(Color.gray).cornerRadius(10)
					.shadow(radius: 10)
					.gesture(
						DragGesture()
							.onChanged{ value in
								var proposedHeight = self.bottomSheetHeight - value.translation.height
								proposedHeight = min(proposedHeight, maxHeight + extraHeightLimits)
								proposedHeight = max(proposedHeight, minimumHeight - extraHeightLimits)
								bottomSheetHeight = proposedHeight
							}
							.onEnded { value in
								withAnimation(.spring()) {
									var proposedHeight = self.bottomSheetHeight - value.translation.height
									proposedHeight = min(proposedHeight, maxHeight)
									proposedHeight = max(proposedHeight, minimumHeight)
									bottomSheetHeight = snapToClosest(proposedHeight, snapPoints: snapPoints)
								}
							}
					)
				
				List {
					ForEach(1...10, id: \.self) { item in
						Text("Item \(item)")
					}
				}
			}.background(.green)
			.frame(width: UIScreen.main.bounds.width, height: bottomSheetHeight)
			.offset(y: geometry.size.height - bottomSheetHeight)
			.animation(.interactiveSpring(), value: 20)
		}
		
	}
	
	// Function to find the closest snap point
	  private func snapToClosest(_ height: CGFloat, snapPoints: [CGFloat]) -> CGFloat {
		  let closest = snapPoints.min(by: { abs($0 - height) < abs($1 - height) })
		  return closest!
	  }
}

#Preview {
	ContentView()
}

