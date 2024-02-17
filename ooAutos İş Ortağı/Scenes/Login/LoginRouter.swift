import UIKit

protocol LoginRoutingLogic {
    func routeToMainPage()
}

class LoginRouter: NSObject, LoginRoutingLogic {
    // MARK: - Properties

    var routeToMainCallback: (() -> Void)?

    weak var viewController: LoginViewController?

    func routeToMainPage() {
        routeToMainCallback?()
    }
}
