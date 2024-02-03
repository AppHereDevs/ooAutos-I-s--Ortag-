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
        let workerMainQueueDispatcher = MainQueueDispatchOperator(decoratee: servicesListWorker)

        let presenter = ServicesListPresenter()
        let router = ServicesListRouter()

        let servicesListController = ServicesListViewController(interactor: interactor)
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

private final class MainQueueDispatchOperator<T> {
    private let decoratee: T

    init(decoratee: T) {
        self.decoratee = decoratee
    }

    func dispatch(completion: @escaping () -> Void) {
        if Thread.isMainThread {
            completion()
        } else {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}

extension MainQueueDispatchOperator: ServicesListWorkerLogic where T == ServicesListWorkerLogic {
    func getConsumptionDetail(startDate: String?, endDate: String?, completion: @escaping (Result<CoreModule.SuccessResult<ServicesListModels.ProviderConsumptionDetail.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.getConsumptionDetail(startDate: startDate, endDate: endDate) { result in
            self.dispatch {
                completion(result)
            }
        }
    }
}
