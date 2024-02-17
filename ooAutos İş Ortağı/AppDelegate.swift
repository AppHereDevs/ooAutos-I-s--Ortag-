import ApiClient
import class AppHereComponents.AppHereThemeManager
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private lazy var navigationController = UINavigationController()

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard window != nil else { return false }

        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear

        AppHereThemeManager.setup(themesJSONFileName: "ViewThemes")

        ApiClient.setup()

        UITextView.appearance().backgroundColor = .white
        UITextView.appearance().textColor = .black

        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        startAppFlow()

        return true
    }

    private func startAppFlow() {
        let splashRouter = SplashRouter()
        splashRouter.routeToLoginCallback = { viewController in
            let loginViewController = LoginUIComposer.loginComposedWith(loginWorker: ApiClient.shared)
            viewController?.navigationController?.viewControllers = [loginViewController]
        }

        splashRouter.routeToMainCallback = { viewController in
            let mainViewController = CustomTabBarController.instantiate()
            viewController?.navigationController?.viewControllers = [mainViewController]
        }

        let splashViewController = SplashViewController(router: splashRouter)

        splashRouter.viewController = splashViewController

        navigationController.pushViewController(splashViewController, animated: true)
    }
}
