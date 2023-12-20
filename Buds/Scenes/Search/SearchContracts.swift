import MapKit

/// View ->  Interactor
protocol SearchInteractorProtocol: AnyObject {
	
	func searchPlace(for query: String)
}


/// Interactor ->  Presenter
protocol SearchPresenterProtocol: ObservableObject {
	
	var bottomSheetType: HeaderSheetTypes { get set }
	var title: String { get set }

	
	func updateSearchResults(items: [MKMapItem])
}
