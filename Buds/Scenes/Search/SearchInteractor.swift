import SwiftUI
import MapKit

class SearchInteractor {

	private var presenter: any SearchPresenterProtocol
	
	init(presenter: any SearchPresenterProtocol) {
		self.presenter = presenter
	}

}

extension SearchInteractor: SearchInteractorProtocol {

	func searchPlace(for query: String) {
		let request = MKLocalSearch.Request()
		request.naturalLanguageQuery = query
		request.resultTypes = .pointOfInterest
		request.region = MKCoordinateRegion (
			center: .parking,
			span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)
		)
		Task { [weak self] in
			let search = MKLocalSearch(request: request)
			let response = try? await search.start()
			self?.presenter.updateSearchResults(items: response?.mapItems ?? [])
		}
	}
}
