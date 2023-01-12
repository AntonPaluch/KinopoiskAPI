import UIKit

final class CustomTabBar: UITabBarController {
    
    convenience init(_ viewControllers: [UIViewController]) {
        self.init()
        setViewControllers(viewControllers, animated: false)
        selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .green
        tabBar.unselectedItemTintColor = .gray
        tabBar.barTintColor = .gray
        //tabBar.backgroundColor = UIColor.Colors.Border.defaultDivider
        //tabBar.isTranslucent = true
    }
}
