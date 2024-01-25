import ApiClient
import UIKit

protocol NavigationRestarting: AnyObject {
    func restartFromLogin()
}

extension UIViewController: NavigationRestarting {
    func restartFromLogin() {
        DispatchQueue.main.async {
            self.restartFromViewController(LoginViewController(worker: ApiClient.shared))
            UserDefaultsManager.shared.resetData()
        }
    }

    func restartFromViewController(_ viewController: UIViewController) {
        
        self.navigationController?.viewControllers = [LoginViewController(worker: ApiClient.shared)]
        
    }
}
