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

        // Override point for customization after application launch.
        startAppFlow()

        return true
    }

    private func startAppFlow() {
        let splashViewController = SplashViewController()
        navigationController.pushViewController(splashViewController, animated: true)
    }
}
