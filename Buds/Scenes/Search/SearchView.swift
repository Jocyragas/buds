import MapKit
import SwiftUI

extension CLLocationCoordinate2D {
	
	static let parking = CLLocationCoordinate2D(latitude: -3.795275, longitude: -38.488830)
}

extension SearchView: BViewProtocol where Presenter: SearchPresenterProtocol {
	
	static func create() -> SearchView<Presenter>? {
		guard let presenter = SearchPresenter() as? Presenter else { return nil }
		let interactor = SearchInteractor(presenter: presenter)
		return SearchView(presenter: presenter, interactor: interactor)
	}
}

struct SearchView<Presenter: SearchPresenterProtocol>: View {
	@ObservedObject private var presenter: Presenter
	private let interactor: SearchInteractorProtocol
	let snapPoints: [CGFloat] = [142, 256, 1200]
	
	init(presenter: Presenter, interactor: SearchInteractorProtocol) {
		self.presenter = presenter
		self.interactor = interactor
	}


	var body: some View {
		ZStack(alignment: .bottom) {
			Map {
				Marker("Parking", coordinate: .parking)
			}.mapStyle(.standard)
			BBottomSheetView(
				bottomSheetInitialHeight: 100,
				headerSheetType: $presenter.bottomSheetType,
				title: $presenter.title,
				snapPoints: snapPoints
			) {
				Button("clique here"){
					interactor.searchPlace(for: "dsadasgfag")
				}.buttonStyle(.primaryButton).frame(width: 300, height: 300)
			}
		}
	}
}

#Preview {
	SearchView<SearchPresenter>.create()
}
