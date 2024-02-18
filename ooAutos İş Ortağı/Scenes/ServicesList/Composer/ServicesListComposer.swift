import CoreModule
import Foundation

final class ServicesListUIComposer {
    private init() {}

    static func servicesListComposedWith(servicesListWorker: ServicesListWorkerLogic, routeToLoginCallback: @escaping (() -> Void)) -> ServicesListViewController {
        let interactor = ServicesListInteractor()
        let servicesListController = ServicesListViewController(interactor: interactor)

        let errorDisplayer = SwiftMessagesManager()
        let errorLogger = OSErrorLogger()
        let errorManagerDecorator: ServicesListWorkerLogic = ooAutosNetworkErrorHandler(decoratee: servicesListWorker, alertDisplayer: errorDisplayer, errorLogger: errorLogger, tokenExpireCallback: routeToLoginCallback) // Decorator 1

        let workerMainQueueDispatcher = MainQueueDispatchOperator(decoratee: errorManagerDecorator) // Decorator 2

        let presenter = ServicesListPresenter()

        let consumptionViewAdapter = ConsumptionViewAdapter(controller: servicesListController)

        interactor.presenter = presenter
        interactor.worker = workerMainQueueDispatcher
        presenter.consumptionView = consumptionViewAdapter

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
