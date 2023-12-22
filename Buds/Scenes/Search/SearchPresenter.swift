import SwiftUI
import MapKit

class SearchPresenter: ObservableObject {
	
	@Published var searchResults: [MKMapItem] = []
	@Published var title: String = "Request a buddy"
	@Published var bottomSheetType = HeaderSheetTypes.grayBarTitleLeft


}

extension SearchPresenter: SearchPresenterProtocol {
	
	func updateSearchResults(items: [MKMapItem]) {
		title = "hahaha"
	}
}
