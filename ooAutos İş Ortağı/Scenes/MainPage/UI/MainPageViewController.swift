import UIKit

protocol MainPageDisplayLogic: AnyObject {
    func displayProviderInfo(providerViewModel: MainPageModels.ProviderViewModel)
    func displayProviderStatus(with status: Bool)
    func displayConsumptionDetail(consumptionDetailViewModel: MainPageModels.ConsumptionDetailViewModel)

    func displayDailyConsumption(consumptionAmount: String)
    func displayMonthlyConsumption(consumptionAmount: String)
    func displayYearlyConsumption(consumptionAmount: String)

    func hideLoadingIndicator()
}

class MainPageViewController: UIViewController, MainPageDisplayLogic {
    // MARK: - Properties

    var router: (NSObjectProtocol & MainPageRoutingLogic)?
    private var interactor: MainPageBusinessLogic?

    private let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var serviceProviderNameLabel: UILabel!
    @IBOutlet private var yearlyCountLabel: UILabel!
    @IBOutlet private var monthlyCountLabel: UILabel!
    @IBOutlet private var dailyCountLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var plateLabel: UILabel!
    @IBOutlet private var isActiveSwitch: UISwitch!

    // MARK: - Object lifecycle

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }

    init() {
        super.init(nibName: nil, bundle: .main)
    }

    convenience init(interactor: MainPageBusinessLogic) {
        self.init()
        self.interactor = interactor
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingIndicator.color = .white
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)

        setupBackgroundImage(imageName: "background")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        interactor?.getProviderInformation()
        interactor?.getConsumptionInformation()
        interactor?.getConsumptionDetail(startDate: nil, endDate: nil)
        showLoadingIndicator(loadingIndicator: loadingIndicator)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        hideLoadingIndicator(loadingIndicator: loadingIndicator)
    }

    func displayProviderInfo(providerViewModel: MainPageModels.ProviderViewModel) {
        scoreLabel.text = providerViewModel.rating
        isActiveSwitch.isOn = providerViewModel.isOpenNow
        serviceProviderNameLabel.text = providerViewModel.name
    }

    func displayDailyConsumption(consumptionAmount: String) {
        dailyCountLabel.text = consumptionAmount
    }

    func displayMonthlyConsumption(consumptionAmount: String) {
        monthlyCountLabel.text = consumptionAmount
    }

    func displayYearlyConsumption(consumptionAmount: String) {
        yearlyCountLabel.text = consumptionAmount
    }

    func displayConsumptionDetail(consumptionDetailViewModel: MainPageModels.ConsumptionDetailViewModel) {
        plateLabel.text = consumptionDetailViewModel.plate
        timeLabel.text = consumptionDetailViewModel.time
        dateLabel.text = consumptionDetailViewModel.date
    }

    func displayProviderStatus(with status: Bool) {
        isActiveSwitch.isOn = status
    }

    func hideLoadingIndicator() {
        hideLoadingIndicator(loadingIndicator: loadingIndicator)
    }

    @IBAction func switchValueChanged(_: Any) {
        if !isActiveSwitch.isOn {
            interactor?.suspendServiceProvider()
        } else {
            interactor?.restoreServiceProvider()
        }
    }
}
