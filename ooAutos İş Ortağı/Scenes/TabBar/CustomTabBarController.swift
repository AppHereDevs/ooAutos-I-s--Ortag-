import Foundation
import UIKit

final class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    @IBInspectable var initalIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        setupNavigationBar(titleViewImageName: "ooAutos-icon")
        selectedIndex = initalIndex

        if let tabBarItem3 = tabBar.items?[3] {
            tabBarItem3.image = UIImage(named: "profile")
            tabBarItem3.title = "Profil"
            tabBarItem3.selectedImage = UIImage(named: "profile")
        }

        if let tabBarItem2 = tabBar.items?[2] {
            tabBarItem2.image = UIImage(named: "servicesList")
            tabBarItem2.title = "Hizmet Listesi"
            tabBarItem2.selectedImage = UIImage(named: "servicesList")
        }

        if let tabBarItem1 = tabBar.items?[1] {
            tabBarItem1.image = UIImage(named: "qrLogo")
            tabBarItem1.title = "QR"
            tabBarItem1.selectedImage = UIImage(named: "qrLogo")
        }

        if let tabBarItem0 = tabBar.items?[0] {
            tabBarItem0.image = UIImage(named: "home")
            tabBarItem0.title = "Anasayfa"
            tabBarItem0.selectedImage = UIImage(named: "home")
        }
    }

    static func instantiate(viewControllers: [UIViewController]) -> Self {
        let bundle = Bundle(for: Self.self)
        let storyboard = UIStoryboard(name: "TabBar", bundle: bundle)
        if let vc = storyboard.instantiateViewController(withIdentifier: "CustomTabBar") as? Self {
            vc.viewControllers = viewControllers
            return vc
        } else {
            fatalError("Developer error, create TabBar storyboard")
        }
    }

    func setupNavigationBar(titleViewImageName: String) {
        if let titleViewImage = UIImage(named: titleViewImageName) {
            navigationItem.titleView = UIImageView(image: titleViewImage)
        }
        navigationItem.setHidesBackButton(true, animated: true)
    }
}
