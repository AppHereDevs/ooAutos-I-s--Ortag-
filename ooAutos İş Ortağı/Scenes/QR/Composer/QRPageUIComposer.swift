final class QRPageUIComposer {
    private init() {}

    static func qrPageComposedWith(qrPageWorker: QRWorkerLogic, routeToLoginCallback: @escaping (() -> Void)) -> QRViewController {
        let interactor = QRInteractor()
        let mainPageViewController = QRViewController(interactor: interactor)

        let errorDisplayer = SwiftMessagesManager()
        let errorLogger = OSErrorLogger()
        let errorManagerDecorator: QRWorkerLogic = ooAutosNetworkErrorHandler(decoratee: qrPageWorker, alertDisplayer: errorDisplayer, errorLogger: errorLogger, tokenExpireCallback: routeToLoginCallback)

        let workerMainQueueDispatcher = MainQueueDispatchOperator(decoratee: errorManagerDecorator)

        let presenter = QRPresenter()

        interactor.presenter = presenter
        interactor.worker = workerMainQueueDispatcher
        presenter.viewController = mainPageViewController

        return mainPageViewController
    }
}
