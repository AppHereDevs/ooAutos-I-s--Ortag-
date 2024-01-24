import ApiClient
import UIKit

protocol NavigationRestarting: AnyObject {
    func restartFromLogin()
}

extension UIViewController: NavigationRestarting {
    func restartFromLogin() {
        restartFromViewController(LoginViewController(worker: ApiClient.shared))
        UserDefaultsManager.shared.resetData()
    }

    func restartFromViewController(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.viewControllers = [LoginViewController(worker: ApiClient.shared)]
        }
    }
}
