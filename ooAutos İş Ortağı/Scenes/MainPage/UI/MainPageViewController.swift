import UIKit

protocol MainPageDisplayLogic: AnyObject {
    func displayProviderInfo(providerViewModel: MainPageModels.ProviderViewModel)
    func displayProviderStatus(with status: Bool)
    func displayConsumptionDetail(consumptionDetailViewModel: MainPageModels.ConsumptionDetailViewModel)

    func displayDailyConsumption(consumptionAmount: String)
    func displayMonthlyConsumption(consumptionAmount: String)

    func displayYearlyConsumption(consumptionAmount: String)
    func displayConsumptionHistoryNotAvailable(errorText: String)

    func hideLoadingIndicator()
}

class MainPageViewController: UIViewController, MainPageDisplayLogic {
    // MARK: - Properties

    private var interactor: MainPageBusinessLogic?

    private let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    @IBOutlet var serviceProviderStatus: UIView!
    @IBOutlet private var isActiveSwitch: UISwitch!

    @IBOutlet private var consumptionHistory: UIView!
    @IBOutlet private var consumptionDetailTitleLabel: UILabel!
    @IBOutlet private var consumptionDetailView: UIView!
    @IBOutlet private var plateLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!

    @IBOutlet private var consumptionInformation: UIView!
    @IBOutlet private var yearlyCountLabel: UILabel!
    @IBOutlet private var monthlyCountLabel: UILabel!
    @IBOutlet private var dailyCountLabel: UILabel!

    @IBOutlet private var serviceProviderInformation: UIView!
    @IBOutlet private var serviceProviderNameLabel: UILabel!
    @IBOutlet private var scoreLabel: UILabel!

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

    // MARK: Consumption Information

    func displayProviderStatus(with status: Bool) {
        serviceProviderStatus.isHidden = false

        isActiveSwitch.isOn = status
    }

    @IBAction func switchValueChanged(_: Any) {
        if !isActiveSwitch.isOn {
            interactor?.suspendServiceProvider()
        } else {
            interactor?.restoreServiceProvider()
        }
    }

    // MARK: Consumption History

    func displayConsumptionDetail(consumptionDetailViewModel: MainPageModels.ConsumptionDetailViewModel) {
        consumptionHistory.isHidden = false

        plateLabel.isHidden = false
        dateLabel.isHidden = false

        plateLabel.text = consumptionDetailViewModel.plate
        timeLabel.text = consumptionDetailViewModel.time
        dateLabel.text = consumptionDetailViewModel.date
    }

    func displayConsumptionHistoryNotAvailable(errorText: String) {
        consumptionHistory.isHidden = false
        plateLabel.isHidden = true
        dateLabel.isHidden = true

        timeLabel.text = errorText
    }

    // MARK: Consumption Information

    func displayDailyConsumption(consumptionAmount: String) {
        consumptionInformation.isHidden = false

        dailyCountLabel.text = consumptionAmount
    }

    func displayMonthlyConsumption(consumptionAmount: String) {
        consumptionInformation.isHidden = false

        monthlyCountLabel.text = consumptionAmount
    }

    func displayYearlyConsumption(consumptionAmount: String) {
        consumptionInformation.isHidden = false

        yearlyCountLabel.text = consumptionAmount
    }

    // MARK: Service Provider Information

    func displayProviderInfo(providerViewModel: MainPageModels.ProviderViewModel) {
        serviceProviderInformation.isHidden = false

        scoreLabel.text = providerViewModel.rating
        isActiveSwitch.isOn = providerViewModel.isOpenNow
        serviceProviderNameLabel.text = providerViewModel.name
    }

    func hideLoadingIndicator() {
        hideLoadingIndicator(loadingIndicator: loadingIndicator)
    }
}
