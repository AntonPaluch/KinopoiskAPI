import Foundation

protocol SearchPresenterProtocol: AnyObject {
    init(networkService: NetworkServiceProtocol)
    var movies: [Doc] { get set }
    func getSearchMovie(withName: String)
}

final class SearchPresenter: SearchPresenterProtocol {
    var movies: [Doc] = []
    
    weak var view: SearchViewProtocol!
    
    private let networkService: NetworkServiceProtocol
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getSearchMovie(withName: String) {
        self.view.showSpinner()
        networkService.getSearchMovies(name: withName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.movies = movies.docs
            case .failure(let error):
                print(error)
            }
            self.view.setAllMovies()
            self.view.removeSpinner()
        }
    }
}
