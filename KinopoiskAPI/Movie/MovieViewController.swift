import UIKit
import SnapKit

protocol MovieViewProtocol: AnyObject {
    func setAllMovies()
    func showAlert(with error: Error)
    func showSpinner()
    func removeSpinner()
}

final class MovieViewController: UIViewController {
    
    var presenter: MoviePresenterProtocol!
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private let filterButton = UIBarButtonItem(title: "Фильтр", menu: nil)

    private lazy var moviesRefreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .black
        refresh.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refresh
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTableView()
        configureFiltrButton()
        presenter.getBestMovies()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.backgroundColor = .lightGray
        tableView.delegate = self
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.description())
        tableView.refreshControl = moviesRefreshControl
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
        
    private func configureFiltrButton() {
        let allFilms = { [unowned self] (action: UIAction) in
            presenter.movies = []
            presenter.currentPage = 1
            presenter.isDefaultChoice = true
            presenter.getBestMovies()
        }
        let latestFilms = { [unowned self](action: UIAction) in
            presenter.movies = []
            presenter.currentPage = 1
            presenter.isDefaultChoice = false
            presenter.getNewMovies()
        }

        var menuItems: [UIAction] {
            return [
                UIAction(title: "Рекомендованные", image: nil, state: .on, handler: allFilms),
                UIAction(title: "Новые фильмы", image: nil, handler: latestFilms)
            ]
        }

        var sortMenu: UIMenu {
            return UIMenu(children: menuItems)
        }

        filterButton.menu = sortMenu
        filterButton.changesSelectionAsPrimaryAction = true

        self.navigationItem.rightBarButtonItem = filterButton
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
}

// MARK: - TableView data source

extension MovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.description(), for: indexPath) as? MoviesTableViewCell else { return UITableViewCell() }
        let movie = presenter.movies[indexPath.row]
        cell.render(movie)
        return cell
    }
}

// MARK: - TableView delegate

extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = presenter.movies[indexPath.row]
        let detailVC = AssemblyBuilder().createMovieDetailModule(movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = presenter.movies.count - 1
        if indexPath.row == lastIndex {
            if presenter.currentPage < presenter.pages ?? 1 {
                presenter.currentPage += 1
            }
            presenter.isDefaultChoice ? presenter.getBestMovies() : presenter.getNewMovies()
        }
    }
}

// MARK: - MovieViewProtocol

extension MovieViewController: MovieViewProtocol {
    
    func setAllMovies() {
        tableView.reloadData()
    }
    
    func showAlert(with error: Error) {
        let alert = AlertFactory.showAlert(with: error)
        present(alert, animated: true, completion: nil)
    }
        
    @objc private func refresh(sender: UIRefreshControl) {
        presenter.isDefaultChoice ? presenter.getBestMovies() : presenter.getNewMovies()
        sender.endRefreshing()
    }
}

