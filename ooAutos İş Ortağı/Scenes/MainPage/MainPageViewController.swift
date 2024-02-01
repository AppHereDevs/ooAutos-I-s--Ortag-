//
//  MainPageViewController.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainPageDisplayLogic: AnyObject {
    func displayLogin()
    func displayUserInfo(providerViewModel: MainPageModels.ProviderViewModel)
    func displayConsumption(consumptionViewModel: MainPageModels.ConsumptionCountViewModel)
    func displayProviderStatus(with status: Bool)
    func displayConsumptionDetail(consumptionDetailViewModel: MainPageModels.ConsumptionDetailViewModel)
}

class MainPageViewController: UIViewController, MainPageDisplayLogic {
    
    // MARK: - Properties
    var router: (NSObjectProtocol & MainPageRoutingLogic & MainPageDataPassing)?
    var interactor: MainPageBusinessLogic?
    private var worker: MainPageWorkerLogic?
    
    private let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var serviceProviderNameLabel: UILabel!
    @IBOutlet private weak var yearlyCountLabel: UILabel!
    @IBOutlet private weak var monthlyCountLabel: UILabel!
    @IBOutlet private weak var dailyCountLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var plateLabel: UILabel!
    @IBOutlet private weak var isActiveSwitch: UISwitch!
    // MARK: - Object lifecycle
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }
    
    init() {
        super.init(nibName: nil, bundle: .main)
    }
    
    convenience init(worker: MainPageWorkerLogic) {
        self.init()
        self.worker = worker
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = MainPageInteractor()
        let presenter = MainPagePresenter()
        let router = MainPageRouter()
        
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

        loadingIndicator.color = .white
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)

        setupBackgroundImage(imageName: "background")
        showLoadingIndicator(loadingIndicator: loadingIndicator)
        interactor?.getProviderInformation()
        interactor?.getConsumptionInformation()
        interactor?.getConsumptionDetail(startDate: nil, endDate: nil)
    }
    
    func displayLogin() {
        hideLoadingIndicator(loadingIndicator: loadingIndicator)
        restartFromLogin()
    }
    
    func displayUserInfo(providerViewModel: MainPageModels.ProviderViewModel) {
        DispatchQueue.main.async {
            self.scoreLabel.text = providerViewModel.rating
            self.isActiveSwitch.isOn = providerViewModel.isOpenNow
            self.serviceProviderNameLabel.text = providerViewModel.name
            self.hideLoadingIndicator(loadingIndicator: self.loadingIndicator)
        }
    }
    
    func displayConsumption(consumptionViewModel: MainPageModels.ConsumptionCountViewModel) {
        DispatchQueue.main.async {
            self.dailyCountLabel.text = String(consumptionViewModel.daily)
            self.monthlyCountLabel.text = String(consumptionViewModel.monthly)
            self.yearlyCountLabel.text = String(consumptionViewModel.yearly)
        }
    }
    
    func displayConsumptionDetail(consumptionDetailViewModel: MainPageModels.ConsumptionDetailViewModel) {
        DispatchQueue.main.async {
            self.plateLabel.text = consumptionDetailViewModel.plate
            self.timeLabel.text = consumptionDetailViewModel.time
            self.dateLabel.text = consumptionDetailViewModel.date
        }
    }
    
    func displayProviderStatus(with status: Bool) {
        DispatchQueue.main.async {
            self.isActiveSwitch.isOn = status
        }
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        if !isActiveSwitch.isOn {
            interactor?.suspendServiceProvider()
        } else {
            interactor?.restoreServiceProvider()
        }
    }
}
