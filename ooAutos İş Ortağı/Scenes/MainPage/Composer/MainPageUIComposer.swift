final class MainPageUIComposer {
    private init() {}

    static func mainPageComposedWith(mainPageWorker: MainPageWorkerLogic) -> MainPageViewController {
        let interactor = MainPageInteractor()
        let mainPageViewController = MainPageViewController(interactor: interactor)

        let errorDisplayer = UIKitErrorPresenter(viewController: mainPageViewController)
        let errorLogger = OSErrorLogger()
        let errorManagerDecorator: MainPageWorkerLogic = ooAutosErrorHandler(decoratee: mainPageWorker, errorDisplayer: errorDisplayer, errorLogger: errorLogger)

        let workerMainQueueDispatcher = MainQueueDispatchOperator(decoratee: errorManagerDecorator)

        let presenter = MainPagePresenter()

        interactor.presenter = presenter
        interactor.worker = workerMainQueueDispatcher
        presenter.viewController = mainPageViewController

        return mainPageViewController
    }
}
