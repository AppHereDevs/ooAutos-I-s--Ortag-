import Foundation

protocol SplashRoutingLogic {
    func routeToLogin()
    func routeToMainPage()
}

class SplashRouter: NSObject, SplashRoutingLogic {
    // MARK: - Properties

    var routeToLoginCallback: (() -> Void)?
    var routeToMainCallback: (() -> Void)?

    weak var viewController: SplashViewController?

    // MARK: - Routing

    func routeToLogin() {
        routeToLoginCallback?()
    }

    func routeToMainPage() {
        routeToMainCallback?()
    }
}
