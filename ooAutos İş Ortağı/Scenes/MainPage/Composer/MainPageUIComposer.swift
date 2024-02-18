final class MainPageUIComposer {
    private init() {}

    static func mainPageComposedWith(mainPageWorker: MainPageWorkerLogic, routeToLoginCallback: @escaping (() -> Void)) -> MainPageViewController {
        let interactor = MainPageInteractor()
        let mainPageViewController = MainPageViewController(interactor: interactor)

        let errorDisplayer = SwiftMessagesManager()
        let errorLogger = OSErrorLogger()
        let errorManagerDecorator: MainPageWorkerLogic = ooAutosNetworkErrorHandler(decoratee: mainPageWorker, alertDisplayer: errorDisplayer, errorLogger: errorLogger, tokenExpireCallback: routeToLoginCallback)

        let workerMainQueueDispatcher = MainQueueDispatchOperator(decoratee: errorManagerDecorator)

        let presenter = MainPagePresenter()

        interactor.presenter = presenter
        interactor.worker = workerMainQueueDispatcher
        presenter.viewController = mainPageViewController

        return mainPageViewController
    }
}
