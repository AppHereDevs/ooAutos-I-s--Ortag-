import UIKit

protocol ServicesListRoutingLogic {}

class ServicesListRouter: NSObject, ServicesListRoutingLogic {
    // MARK: - Properties

    weak var viewController: ServicesListViewController?

    // MARK: - Routing
}
