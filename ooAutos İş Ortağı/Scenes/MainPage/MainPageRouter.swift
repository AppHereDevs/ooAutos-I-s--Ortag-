import UIKit

protocol MainPageRoutingLogic {}

class MainPageRouter: NSObject, MainPageRoutingLogic {
    // MARK: - Properties

    weak var viewController: MainPageViewController?
}
