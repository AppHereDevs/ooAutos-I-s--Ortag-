final class MainPageUIComposer {
    private init() {}

    static func mainPageComposedWith(mainPageWorker: MainPageWorkerLogic) -> MainPageViewController {
        let interactor = MainPageInteractor()
        let mainPageViewController = MainPageViewController(interactor: interactor)

        let errorDisplayer = UIKitErrorPresenter(viewController: mainPageViewController)
        let errorManagerDecorator: MainPageWorkerLogic = ooAutosErrorHandler(decoratee: mainPageWorker, errorDisplayer: errorDisplayer) // Decorator 1

        let workerMainQueueDispatcher = MainQueueDispatchOperator(decoratee: errorManagerDecorator) // Decorator 2

        let presenter = MainPagePresenter()
        let router = MainPageRouter()

        mainPageViewController.router = router
        interactor.presenter = presenter
        interactor.worker = workerMainQueueDispatcher
        presenter.viewController = mainPageViewController

        router.viewController = mainPageViewController
        return mainPageViewController
    }
}
