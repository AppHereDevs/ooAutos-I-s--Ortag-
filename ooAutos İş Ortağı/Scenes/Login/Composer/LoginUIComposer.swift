final class LoginUIComposer {
    private init() {}

    static func loginComposedWith(loginWorker: LoginWorkerLogic, routeToMainCallback: @escaping (() -> Void)) -> LoginViewController {
        let interactor = LoginInteractor()
        let loginViewController = LoginViewController(interactor: interactor)

        let errorDisplayer = SwiftMessagesManager()
        let errorLogger = OSErrorLogger()
        let errorManagerDecorator: LoginWorkerLogic = ooAutosNetworkErrorHandler(decoratee: loginWorker, alertDisplayer: errorDisplayer, errorLogger: errorLogger, tokenExpireCallback: nil)

        let workerMainQueueDispatcher = MainQueueDispatchOperator(decoratee: errorManagerDecorator)

        let presenter = LoginPresenter()

        let router = LoginRouter()
        router.routeToMainCallback = routeToMainCallback

        loginViewController.router = router
        interactor.presenter = presenter
        interactor.worker = workerMainQueueDispatcher
        presenter.viewController = loginViewController

        router.viewController = loginViewController
        return loginViewController
    }
}
