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
	@State private var searchText: String = ""
	@ObservedObject private var presenter: Presenter
	private let interactor: SearchInteractorProtocol
	let snapPoints: [CGFloat] = [142, 256, 1200]
	let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]

	
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
				bottomSheetInitialHeight: 500,
				headerSheetType: $presenter.bottomSheetType,
				title: $presenter.title,
				snapPoints: snapPoints
			) {
				VStack {
					SimpleDestinationTextField(searchText: $searchText).padding(.horizontal, 16)
					List(items, id: \.self) { item in
						  DestinationTableCell(
							title: "Village",
							subtitle: "3400 Poly Vista, Pomona"
						  )
					}
				}
			}
		}
	}
}

#Preview {
	SearchView<SearchPresenter>.create()
}
