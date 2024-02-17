final class ProfileUIComposer {
    private init() {}

    static func profileComposedWith(profileWorker: ProfileWorkerLogic) -> ProfileViewController {
        let interactor = ProfileInteractor()
        let profileViewController = ProfileViewController(interactor: interactor)

        let errorDisplayer = UIKitErrorPresenter(viewController: profileViewController)
        let errorLogger = OSErrorLogger()
        let errorManagerDecorator: ProfileWorkerLogic = ooAutosErrorHandler(decoratee: profileWorker, errorDisplayer: errorDisplayer, errorLogger: errorLogger)

        let workerMainQueueDispatcher = MainQueueDispatchOperator(decoratee: errorManagerDecorator)

        let presenter = ProfilePresenter()

        interactor.presenter = presenter
        interactor.worker = workerMainQueueDispatcher
        presenter.viewController = profileViewController

        return profileViewController
    }
}
