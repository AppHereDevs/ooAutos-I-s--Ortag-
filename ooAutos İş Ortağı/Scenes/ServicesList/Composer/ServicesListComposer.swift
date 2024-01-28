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
        let servicesListController = ServicesListViewController()
        let interactor = ServicesListInteractor()
        let presenter = ServicesListPresenter()
        let router = ServicesListRouter()

        servicesListController.router = router
        servicesListController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = servicesListWorker
        presenter.viewController = servicesListController
        router.viewController = servicesListController
        return servicesListController
    }
}
