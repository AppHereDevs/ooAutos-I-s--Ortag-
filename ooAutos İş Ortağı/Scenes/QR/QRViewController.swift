import AppHereComponents
import UIKit

protocol QRDisplayLogic: AnyObject {
    func displayQRCode(image: UIImage, stringQR: String)
    func displayLogin()
}

class QRViewController: UIViewController, QRDisplayLogic {
    @IBOutlet private var qrLabel: AppHereLabel!
    @IBOutlet private var qrView: UIImageView!
    @IBOutlet private var backView: UIView!
    @IBOutlet private var titleLabel: AppHereLabel!

    // MARK: - Properties

    var router: (NSObjectProtocol & QRRoutingLogic & QRDataPassing)?
    var interactor: QRBusinessLogic?
    private var worker: QRWorkerLogic?

    // MARK: - Object lifecycle

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }

    init() {
        super.init(nibName: nil, bundle: .main)
    }

    convenience init(worker: QRWorkerLogic) {
        self.init()
        self.worker = worker
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = QRInteractor()
        let presenter = QRPresenter()
        let router = QRRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage(imageName: "background")
        interactor?.getQRInformation()
    }

    func displayQRCode(image: UIImage, stringQR: String) {
        DispatchQueue.main.async {
            self.qrView.image = image
            self.qrLabel.text = stringQR.uppercased()
        }
    }

    func displayLogin() {
        restartFromLogin()
    }
}
