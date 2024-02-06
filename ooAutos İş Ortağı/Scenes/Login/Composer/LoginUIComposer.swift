final class LoginUIComposer {
    private init() {}

    static func loginComposedWith(loginWorker: LoginWorkerLogic) -> LoginViewController {
        let interactor = LoginInteractor()
        let loginViewController = LoginViewController(interactor: interactor)

        let errorDisplayer = UIKitErrorPresenter(viewController: loginViewController)
        let errorManagerDecorator: LoginWorkerLogic = ooAutosErrorHandler(decoratee: loginWorker, errorDisplayer: errorDisplayer) // Decorator 1

        let workerMainQueueDispatcher = MainQueueDispatchOperator(decoratee: errorManagerDecorator) // Decorator 2

        let presenter = LoginPresenter()
        let router = LoginRouter()

        loginViewController.router = router
        interactor.presenter = presenter
        interactor.worker = workerMainQueueDispatcher
        presenter.viewController = loginViewController

        router.viewController = loginViewController
        return loginViewController
    }
}
