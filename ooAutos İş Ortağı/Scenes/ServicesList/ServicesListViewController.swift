//
//  ServicesListViewController.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ServicesListDisplayLogic: AnyObject {
}

class ServicesListViewController: UIViewController, ServicesListDisplayLogic {

    // MARK: - Properties
    var router: (NSObjectProtocol & ServicesListRoutingLogic & ServicesListDataPassing)?
    var interactor: ServicesListBusinessLogic?
    private var worker: ServicesListWorkerLogic?

    // MARK: - Object lifecycle

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }
    
    init() {
        super.init(nibName: nil, bundle: .main)
    }
    
    convenience init(worker: ServicesListWorkerLogic) {
        self.init()
        self.worker = worker
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = ServicesListInteractor()
        let presenter = ServicesListPresenter()
        let router = ServicesListRouter()

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
    }
}
