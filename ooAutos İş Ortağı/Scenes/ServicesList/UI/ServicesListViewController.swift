//
//  ServicesListViewController.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ServicesListDisplayLogic: AnyObject {
    func displayConsumptionHistory(consumptionDetails: [ConsumptionDetail])
}

class ServicesListViewController: UIViewController, ServicesListDisplayLogic {

    // MARK: - Properties
    var router: ServicesListRoutingLogic?
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
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage(imageName: "background")

        interactor?.getConsumptionDetail(startDate: nil, endDate: nil)
    }

    func displayConsumptionHistory(consumptionDetails: [ConsumptionDetail]) {
        
    }
}
