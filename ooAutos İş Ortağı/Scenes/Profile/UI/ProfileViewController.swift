import AppHereComponents
import UIKit

protocol ProfileDisplayLogic: AnyObject {
    func displayLogin()
    func displayPersonalInfo(viewModel: ProfileModels.ViewModel)
}

class ProfileViewController: UIViewController, ProfileDisplayLogic {
    // MARK: - Properties

    @IBOutlet var name: AppHereInputView!
    @IBOutlet var typeDesc: AppHereInputView!
    @IBOutlet var adress: AppHereInputView!
    @IBOutlet var phoneNumber: AppHereInputView!
    @IBOutlet var mobileNumber: AppHereInputView!
    @IBOutlet var email: AppHereInputView!
    @IBOutlet var ibanNo: AppHereInputView!
    @IBOutlet var ibanAccountName: AppHereInputView!
    @IBOutlet var workingHours: AppHereInputView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var signOutButton: AppHereButton!

    var interactor: ProfileBusinessLogic?
    private var worker: ProfileWorkerLogic?

    // MARK: - Object lifecycle

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }

    init() {
        super.init(nibName: nil, bundle: .main)
    }

    convenience init(worker: ProfileWorkerLogic) {
        self.init()
        self.worker = worker
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage(imageName: "background")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        name.isHidden = true
        typeDesc.isHidden = true
        adress.isHidden = true
        phoneNumber.isHidden = true
        mobileNumber.isHidden = true
        email.isHidden = true
        ibanNo.isHidden = true
        ibanAccountName.isHidden = true
        workingHours.isHidden = true

        interactor?.getProfileInfo()
    }

    func displayPersonalInfo(viewModel: ProfileModels.ViewModel) {
        DispatchQueue.main.async {
            self.name.viewModel = AppHereInputViewModel(
                title: "İSİM",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 64)
            )
            self.name.inputTextField.text = viewModel.name
            self.name.isUserInteractionEnabled = false
            self.name.isHidden = false

            self.typeDesc.viewModel = AppHereInputViewModel(
                title: "TİPİ",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 64)
            )
            self.typeDesc.inputTextField.text = viewModel.typeDesc
            self.typeDesc.isUserInteractionEnabled = false
            self.typeDesc.isHidden = false

            self.adress.viewModel = AppHereInputViewModel(
                title: "ADRES",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 256)
            )
            self.adress.inputTextField.text = viewModel.address
            self.adress.isUserInteractionEnabled = false
            self.adress.isHidden = false

            self.phoneNumber.viewModel = AppHereInputViewModel(
                title: "TELEFON NUMARASI",
                placeholder: "",
                keyboardType: .phonePad,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 64)
            )
            self.phoneNumber.inputTextField.text = viewModel.telephoneNo
            self.phoneNumber.isUserInteractionEnabled = false
            self.phoneNumber.isHidden = false

            self.mobileNumber.viewModel = AppHereInputViewModel(
                title: "MOBİL NUMARASI",
                placeholder: "",
                keyboardType: .phonePad,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 64)
            )
            self.mobileNumber.inputTextField.text = viewModel.mobileNo
            self.mobileNumber.isUserInteractionEnabled = false
            self.mobileNumber.isHidden = false

            self.email.viewModel = AppHereInputViewModel(
                title: "EMAİL",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 64)
            )
            self.email.inputTextField.text = viewModel.email
            self.email.isUserInteractionEnabled = false
            self.email.isHidden = false

            self.ibanNo.viewModel = AppHereInputViewModel(
                title: "IBAN NO",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 256)
            )
            self.ibanNo.inputTextField.text = viewModel.ibanNo
            self.ibanNo.isUserInteractionEnabled = false
            self.ibanNo.isHidden = false

            self.ibanAccountName.viewModel = AppHereInputViewModel(
                title: "HESAP BİLGİSİ",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 256)
            )
            self.ibanAccountName.inputTextField.text = viewModel.ibanName
            self.ibanAccountName.isUserInteractionEnabled = false
            self.ibanAccountName.isHidden = false

            self.workingHours.viewModel = AppHereInputViewModel(
                title: "ÇALIŞMA BİLGİSİ",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 256)
            )
            self.workingHours.inputTextField.text = viewModel.workingHours
            self.workingHours.isUserInteractionEnabled = false
            self.workingHours.isHidden = false
        }
    }

    @IBAction func signOut(_: Any) {
        restartFromLogin()
    }

    func displayLogin() {
        restartFromLogin()
    }
}
