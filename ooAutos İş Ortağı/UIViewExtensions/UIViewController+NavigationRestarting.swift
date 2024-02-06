import ApiClient
import UIKit

protocol NavigationRestarting: AnyObject {
    func restartFromLogin()
}

extension UIViewController: NavigationRestarting {
    func restartFromLogin() {
        DispatchQueue.main.async {
            self.navigationController?.viewControllers = 
            [LoginUIComposer.loginComposedWith(loginWorker: ApiClient.shared)]
            UserDefaultsManager.shared.resetData()
        }
    }
}
