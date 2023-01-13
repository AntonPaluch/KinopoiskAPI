import Foundation

protocol MoviePresenterProtocol: AnyObject {
    init(networkService: NetworkServiceProtocol)
    var movies: [Doc] { get set}
    var isDefaultChoice: Bool { get set}
    var currentPage: Int { get set}
    var pages: Int? { get set}
    func getBestMovies()
    func getNewMovies()
}

final class MoviePresenter: MoviePresenterProtocol {
    var movies: [Doc] = []
    var pages: Int?
    var currentPage = 1
    var isDefaultChoice = true
    
    weak var view: MovieViewProtocol!
    
    private let networkService: NetworkServiceProtocol
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getBestMovies() {
        self.view.showSpinner()
        networkService.getBestMovies(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.movies.append(contentsOf: movies.docs)
                self.pages = movies.pages
            case .failure(let error):
                print(error)
                self.view.showAlert(with: error)
                self.view.removeSpinner()
            }
            self.view.setAllMovies()
            self.view.removeSpinner()
        }
    }
    
    func getNewMovies() {
        self.view.showSpinner()
        networkService.getNewMovies(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.movies.append(contentsOf: movies.docs)
                self.pages = movies.pages
            case .failure(let error):
                self.view.showAlert(with: error)
            }
            self.view.setAllMovies()
            self.view.removeSpinner()
        }
    }
}

