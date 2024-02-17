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

    convenience init(interactor: QRBusinessLogic) {
        self.init()
        self.interactor = interactor
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage(imageName: "background")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        qrView.isHidden = true
        qrLabel.isHidden = true
        interactor?.getQRInformation()
    }

    func displayQRCode(image: UIImage, stringQR: String) {
        DispatchQueue.main.async {
            self.qrView.isHidden = false
            self.qrView.image = image

            self.qrLabel.isHidden = false
            self.qrLabel.text = stringQR.uppercased()
        }
    }

    func displayLogin() {
        restartFromLogin()
    }
}
