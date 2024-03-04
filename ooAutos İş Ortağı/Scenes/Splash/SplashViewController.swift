import UIKit

class SplashViewController: UIViewController {
    // MARK: - Properties

    var router: SplashRoutingLogic?

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }

    init() {
        super.init(nibName: nil, bundle: .main)
    }

    convenience init(router: SplashRoutingLogic) {
        self.init()
        self.router = router
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage(imageName: "background")
        setupCenterIcon()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if UserDefaultsManager.shared.loginStatus {
                debugPrint("JWTToken \(UserDefaultsManager.shared.jwtToken.valueOrEmpty)")
                self.router?.routeToMainPage()

            } else {
                self.router?.routeToLogin()
            }
        }
    }

    private func setupCenterIcon() {
        let imageView = UIImageView(image: UIImage(named: "splashLogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        let aspectRatio = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: 15.0 / 8.0, constant: 0)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.57),
            aspectRatio,
        ])
    }
}
