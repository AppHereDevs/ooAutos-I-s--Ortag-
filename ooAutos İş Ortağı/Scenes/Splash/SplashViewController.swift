import UIKit

protocol SplashDisplayLogic: AnyObject {}

class SplashViewController: UIViewController, SplashDisplayLogic {
    // MARK: - Properties

    var router: (NSObjectProtocol & SplashRoutingLogic & SplashDataPassing)?
    var interactor: SplashBusinessLogic?

    // MARK: - Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = SplashInteractor()
        let presenter = SplashPresenter()
        let router = SplashRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage(imageName: "background")
        setupCenterIcon()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
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
