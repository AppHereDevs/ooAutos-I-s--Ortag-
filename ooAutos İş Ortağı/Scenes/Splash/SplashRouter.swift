import ApiClient
import UIKit

protocol SplashRoutingLogic {
    func routeToLogin()
    func routeToMainPage()
}

protocol SplashDataPassing {
    var dataStore: SplashDataStore? { get }
}

class SplashRouter: NSObject, SplashRoutingLogic, SplashDataPassing {
    // MARK: - Properties

    weak var viewController: SplashViewController?
    var dataStore: SplashDataStore?

    // MARK: - Routing

    func routeToLogin() {
        let loginViewController = LoginUIComposer.loginComposedWith(loginWorker: ApiClient.shared)
        viewController?.navigationController?.viewControllers = [loginViewController]
    }

    func routeToMainPage() {
        let mainViewController = CustomTabBarController.instantiate()
        viewController?.navigationController?.viewControllers = [mainViewController]
    }
}
