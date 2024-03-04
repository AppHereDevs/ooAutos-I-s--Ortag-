import ApiClient
import AppHereComponents
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private lazy var navigationController = UINavigationController()

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard window != nil else { return false }

        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear

        AppHereThemeManager.setup(themesJSONFileName: "ViewThemes")

        ApiClient.setup()

        UITextView.appearance().backgroundColor = .white
        UITextView.appearance().textColor = .black

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        startAppFlow()

        return true
    }

    private func startAppFlow() {
        let routeToMainCallback = { [weak self] in
            guard let self else { return }

            let customTabBarController = CustomTabBarController.instantiate(viewControllers: createTabBarModules())
            navigationController.viewControllers = [customTabBarController]
        }

        let splashRouter = SplashRouter()
        splashRouter.routeToLoginCallback = { [weak self] in
            guard let self else { return }

            let loginViewController = LoginUIComposer.loginComposedWith(loginWorker: ApiClient.shared, routeToMainCallback: routeToMainCallback)
            navigationController.viewControllers = [loginViewController]
        }
        splashRouter.routeToMainCallback = { [weak self] in
            guard let self else { return }

            let customTabBarController = CustomTabBarController.instantiate(viewControllers: createTabBarModules())
            navigationController.viewControllers = [customTabBarController]
        }

        let splashViewController = SplashViewController(router: splashRouter)

        splashRouter.viewController = splashViewController

        navigationController.pushViewController(splashViewController, animated: true)
    }

    private func createTabBarModules() -> [UIViewController] {
        let routeToMainCallback = { [weak self] in
            guard let self else { return }

            DispatchQueue.main.async {
                let customTabBarController = CustomTabBarController.instantiate(viewControllers: self.createTabBarModules())
                self.navigationController.viewControllers = [customTabBarController]
            }
        }

        let routeToLoginCallBack = { [weak self] in
            guard let self else { return }

            DispatchQueue.main.async {
                let loginViewController = LoginUIComposer.loginComposedWith(loginWorker: ApiClient.shared, routeToMainCallback: routeToMainCallback)
                self.navigationController.viewControllers = [loginViewController]
            }
        }

        let mainPage = MainPageUIComposer.mainPageComposedWith(mainPageWorker: ApiClient.shared, routeToLoginCallback: routeToLoginCallBack)
        let qrPage = QRPageUIComposer.qrPageComposedWith(qrPageWorker: ApiClient.shared, routeToLoginCallback: routeToLoginCallBack)
        let servicesList = ServicesListUIComposer.servicesListComposedWith(servicesListWorker: ApiClient.shared, routeToLoginCallback: routeToLoginCallBack)
        let profile = ProfileUIComposer.profileComposedWith(profileWorker: ApiClient.shared, routeToLoginCallback: routeToLoginCallBack)

        return [mainPage, qrPage, servicesList, profile]
    }
}
