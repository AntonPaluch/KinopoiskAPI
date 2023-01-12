import UIKit

protocol SearchViewProtocol: AnyObject {
    func setAllMovies()
    func showAlert(with error: Error)
    func showSpinner()
    func removeSpinner()
}

final class SearchViewController: UIViewController {
    
    var presenter: SearchPresenterProtocol!
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Название фильма"
        return searchBar
    }()
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        navigationController?.hideKeyboardWhenTappedAround()
        setupTableView()
        view.backgroundColor = .white
        searchBar.delegate = self
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.description())
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SearchViewController: SearchViewProtocol {
    func setAllMovies() {
        tableView.reloadData()
    }
    
    func showAlert(with error: Error) {
        let alert = AlertFactory.showAlert(with: error)
        present(alert, animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(presenter.movies.count)
        return presenter.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.description(), for: indexPath) as? MoviesTableViewCell else { return UITableViewCell() }
        let movie = presenter.movies[indexPath.row]
        cell.render(movie)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = presenter.movies[indexPath.row]
        let detailVC = AssemblyBuilder().createMovieDetailModule(movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            presenter.getSearchMovie(withName: searchText)
        }
        if searchText.isEmpty {
//            presenter.movies.removeAll()
//            tableView.reloadData()
        }
    }
}


