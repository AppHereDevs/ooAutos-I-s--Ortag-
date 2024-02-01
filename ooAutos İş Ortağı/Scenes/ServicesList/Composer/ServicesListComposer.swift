//
//  ServicesListComposer.swift
//  ooAutos İş Ortağı
//
//  Created by Arda Onat on 28/01/2024.
//

import Foundation

final class ServicesListUIComposer {
    private init() {}

    static func servicesListComposedWith(servicesListWorker: ServicesListWorkerLogic) -> ServicesListViewController {
        let interactor = ServicesListInteractor()
        let presenter = ServicesListPresenter()
        let router = ServicesListRouter()

        let servicesListController = ServicesListViewController(interactor: interactor)
        let consumptionViewAdapter = ConsumptionViewAdapter(controller: servicesListController)

        servicesListController.router = router
        interactor.presenter = presenter
        interactor.worker = servicesListWorker
        presenter.consumptionView = consumptionViewAdapter
        router.viewController = servicesListController
        return servicesListController
    }
}


private final class ConsumptionViewAdapter: ConsumptionView {
    private let controller: ServicesListViewController

    init(controller: ServicesListViewController) {
        self.controller = controller
    }

    func displayConsumptionHistory(consumptionDetails: [ConsumptionDetail]) {
        DispatchQueue.main.async {
            self.controller.tableModel = consumptionDetails.map {
                ConsumptionDetailCellController(model: $0)
            }
        }
    }
}
