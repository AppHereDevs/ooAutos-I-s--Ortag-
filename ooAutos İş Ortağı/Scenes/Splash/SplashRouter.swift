import ApiClient
import UIKit

protocol SplashRoutingLogic {
    func routeToLogin()
    func routeToMainPage()
}

class SplashRouter: NSObject, SplashRoutingLogic {
    // MARK: - Properties

    var routeToLoginCallback: ((SplashViewController?) -> Void)?
    var routeToMainCallback: ((SplashViewController?) -> Void)?

    weak var viewController: SplashViewController?

    // MARK: - Routing

    func routeToLogin() {
        routeToLoginCallback?(viewController)
    }

    func routeToMainPage() {
        routeToMainCallback?(viewController)
    }
}
