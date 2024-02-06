import UIKit

protocol LoginRoutingLogic {
    func routeToLogin()
    func routeToMainPage()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    // MARK: - Properties

    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?

    func routeToMainPage() {
        let mainViewController = CustomTabBarController.instantiate()
        viewController?.navigationController?.viewControllers = [mainViewController]
    }

    func routeToLogin() {
        let loginViewController = LoginViewController()
        viewController?.navigationController?.viewControllers = [loginViewController]
    }
}
