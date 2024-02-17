final class QRPageUIComposer {
    private init() {}

    static func qrPageComposedWith(qrPageWorker: QRWorkerLogic) -> QRViewController {
        let interactor = QRInteractor()
        let mainPageViewController = QRViewController(interactor: interactor)

        let errorDisplayer = UIKitErrorPresenter(viewController: mainPageViewController)
        let errorLogger = OSErrorLogger()
        let errorManagerDecorator: QRWorkerLogic = ooAutosErrorHandler(decoratee: qrPageWorker, errorDisplayer: errorDisplayer, errorLogger: errorLogger)

        let workerMainQueueDispatcher = MainQueueDispatchOperator(decoratee: errorManagerDecorator)

        let presenter = QRPresenter()

        interactor.presenter = presenter
        interactor.worker = workerMainQueueDispatcher
        presenter.viewController = mainPageViewController

        return mainPageViewController
    }
}
