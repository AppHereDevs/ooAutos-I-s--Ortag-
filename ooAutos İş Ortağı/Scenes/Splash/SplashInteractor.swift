import UIKit

protocol SplashBusinessLogic {}

protocol SplashDataStore {}

class SplashInteractor: SplashBusinessLogic, SplashDataStore {
    // MARK: - Properties

    lazy var worker = SplashWorker()
    var presenter: SplashPresentationLogic?
}
