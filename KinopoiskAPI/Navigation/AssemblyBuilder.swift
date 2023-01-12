import UIKit

struct AssemblyBuilder {
    
    func createMovieModule() -> UIViewController {
        let view = MovieViewController()
        let networkService = NetworkService()
        let presenter = MoviePresenter(networkService: networkService)
        view.presenter = presenter
        presenter.view = view
        return view
    }
    
    func createMovieDetailModule(movie: Doc) -> UIViewController {
        let view = MovieDetailViewController()
        let networkService = NetworkService()
        let presenter = MovieDetailPresenter(networkService: networkService, movie: movie)
        view.presenter = presenter
        presenter.view = view
        return view
    }
    
    func createSearchModule() -> UIViewController {
        let view = SearchViewController()
        let networkService = NetworkService()
        let presenter = SearchPresenter(networkService: networkService)
        view.presenter = presenter
        presenter.view = view
        return view
    }
    
    
}
