import UIKit

class TabBarController: UITabBarController {
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        let movieViewController = AssemblyBuilder().createMovieModule()
        let searchViewController = AssemblyBuilder().createSearchModule()
        
        viewControllers = [
            setupUI(
                rootViewController: movieViewController,
                image: Images.tabBar.movie,
                titleNavBar: Strings.NavBar.movie,
                titleTabBar: Strings.TabBar.movie
            ),
            setupUI(
                rootViewController: searchViewController,
                image: Images.tabBar.search,
                titleNavBar: Strings.NavBar.search,
                titleTabBar: Strings.TabBar.search
            )
        ]
        
    }
    
    private func setupUI(rootViewController: UIViewController, image: UIImage?, titleNavBar: String, titleTabBar: String?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = titleTabBar
        tabBar.barTintColor = UIColor(red: 248, green: 248, blue: 248, alpha: 0.92)
        navigationVC.navigationBar.topItem?.title = titleNavBar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor(red: 248, green: 248, blue: 248, alpha: 0.92)
        navigationVC.navigationBar.standardAppearance = navBarAppearance
        navigationVC.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        return navigationVC
    }
}
