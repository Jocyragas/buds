import SwiftUI

class SearchInteractor {

	private var presenter: any SearchPresenterProtocol
	
	init(presenter: any SearchPresenterProtocol) {
		self.presenter = presenter
	}

}

extension SearchInteractor: SearchInteractorProtocol {

	func searchPlace(for query: String) {
		presenter.updateSearchResults(items: [])
	}
}
