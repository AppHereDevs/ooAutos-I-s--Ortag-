//
//  ServicesListComposer.swift
//  ooAutos İş Ortağı
//
//  Created by Arda Onat on 28/01/2024.
//

import CoreModule
import Foundation

final class ServicesListUIComposer {
    private init() {}

    static func servicesListComposedWith(servicesListWorker: ServicesListWorkerLogic) -> ServicesListViewController {
        let interactor = ServicesListInteractor()
        let servicesListController = ServicesListViewController(interactor: interactor)

        let errorDisplayer = UIKitErrorPresenter(viewController: servicesListController)
        let errorManagerDecorator: ServicesListWorkerLogic = ooAutosErrorHandler(decoratee: servicesListWorker, errorDisplayer: errorDisplayer) // Decorator 1

        let workerMainQueueDispatcher = MainQueueDispatchOperator(decoratee: errorManagerDecorator) // Decorator 2

        let presenter = ServicesListPresenter()
        let router = ServicesListRouter()

        let consumptionViewAdapter = ConsumptionViewAdapter(controller: servicesListController)

        servicesListController.router = router
        interactor.presenter = presenter
        interactor.worker = workerMainQueueDispatcher
        presenter.consumptionView = consumptionViewAdapter
        presenter.loginDisplayer = servicesListController

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
        controller.tableModel = consumptionDetails.map {
            ConsumptionDetailCellController(model: $0)
        }
    }
}
