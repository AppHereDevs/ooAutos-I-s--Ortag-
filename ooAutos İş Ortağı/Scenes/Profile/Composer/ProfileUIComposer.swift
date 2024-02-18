final class ProfileUIComposer {
    private init() {}

    static func profileComposedWith(profileWorker: ProfileWorkerLogic, routeToLoginCallback: @escaping (() -> Void)) -> ProfileViewController {
        let interactor = ProfileInteractor()
        let profileViewController = ProfileViewController(interactor: interactor, routeToStartingPage: routeToLoginCallback)

        let errorDisplayer = SwiftMessagesManager()
        let errorLogger = OSErrorLogger()
        let errorManagerDecorator: ProfileWorkerLogic = ooAutosNetworkErrorHandler(decoratee: profileWorker, alertDisplayer: errorDisplayer, errorLogger: errorLogger, tokenExpireCallback: routeToLoginCallback)

        let workerMainQueueDispatcher = MainQueueDispatchOperator(decoratee: errorManagerDecorator)

        let presenter = ProfilePresenter()

        interactor.presenter = presenter
        interactor.worker = workerMainQueueDispatcher
        presenter.viewController = profileViewController

        return profileViewController
    }
}
