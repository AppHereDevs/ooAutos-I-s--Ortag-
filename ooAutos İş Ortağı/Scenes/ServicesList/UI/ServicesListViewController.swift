import AppHereComponents
import Foundation
import SwiftMessages
import UIKit

public final class ServicesListViewController: UIViewController {
    // MARK: - Properties

    private var interactor: ServicesListBusinessLogic?

    @IBOutlet private var informationLabel: AppHereLabel!
    @IBOutlet private var tableView: UITableView!
    private let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "TR")
        df.dateFormat = "dd/MM/yyyy"
        return df
    }()

    private static let userCalendar = Calendar(identifier: .gregorian)

    private static let minimumDateComponents = DateComponents(timeZone: TimeZone(abbreviation: "TR"), year: 2023, month: 1, day: 1)
    private static let minimumDate: Date = userCalendar.date(from: minimumDateComponents)!
    private static let minimumDateString = dateFormatter.string(from: ServicesListViewController.minimumDate)

    private static let today: Date = .now
    private static let todayDateString = dateFormatter.string(from: ServicesListViewController.today)

    var tableModel = [ConsumptionDetailCellController]() {
        didSet {
            hideLoadingIndicator(loadingIndicator: loadingIndicator)
            tableView.reloadData()

            if tableModel.isEmpty {
                informationLabel.text = "Görüntülenecek kaydınız bulunmamaktadır."
            }
        }
    }

    // MARK: - Object lifecycle

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }

    init() {
        super.init(nibName: nil, bundle: .main)
    }

    convenience init(interactor: ServicesListBusinessLogic) {
        self.init()
        self.interactor = interactor
    }

    // MARK: - View Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ConsumptionDetailCell", bundle: nil), forCellReuseIdentifier: "ConsumptionDetailCell")

        loadingIndicator.color = .white
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)

        setupBackgroundImage(imageName: "background")
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        informationLabel.text = "\(ServicesListViewController.minimumDateString) ve \(ServicesListViewController.todayDateString) tarihleri arasındaki kullanımlar"

        interactor?.getConsumptionDetail(startDate: nil, endDate: nil)
        showLoadingIndicator(loadingIndicator: loadingIndicator)
    }

    @IBAction func filterButtonPressed(_: Any) {
        let view: DateFilterView = try! SwiftMessages.viewFromNib()

        view.applyFilterButtonAction = { [weak self] startDate, endDate in
            SwiftMessages.hide()

            guard let self else { return }
            informationLabel.text = "\(startDate) ve \(endDate) tarihleri arasındaki kullanımlar"
            interactor?.getConsumptionDetail(startDate: startDate, endDate: endDate)
        }

        view.clearFilterButtonAction = { [weak self] in
            SwiftMessages.hide()

            guard let self else { return }
            informationLabel.text = "\(ServicesListViewController.minimumDateString) ve \(ServicesListViewController.todayDateString) tarihleri arasındaki kullanımlar"
            interactor?.getConsumptionDetail(startDate: nil, endDate: nil)
        }

        SwiftMessages.show(config: filterConfig, view: view)
    }

    var filterConfig: SwiftMessages.Config {
        var config = SwiftMessages.defaultConfig
        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        config.duration = .forever
        config.presentationStyle = .center
        config.dimMode = .gray(interactive: false)
        return config
    }
}

extension ServicesListViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellController(forRowAt: indexPath).view(in: tableView)
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 1
        return cell
    }

    private func cellController(forRowAt indexPath: IndexPath) -> ConsumptionDetailCellController {
        return tableModel[indexPath.row]
    }

    public func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 87
    }

    // Set the spacing between sections
    public func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 }
        return 8
    }

    public func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        1
    }

    public func numberOfSections(in _: UITableView) -> Int {
        return tableModel.count
    }
}
