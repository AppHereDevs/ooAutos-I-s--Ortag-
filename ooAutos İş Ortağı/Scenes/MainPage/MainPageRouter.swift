import UIKit

protocol MainPageRoutingLogic {}

protocol MainPageDataPassing {
    var dataStore: MainPageDataStore? { get }
}

class MainPageRouter: NSObject, MainPageRoutingLogic, MainPageDataPassing {
    // MARK: - Properties

    weak var viewController: MainPageViewController?
    var dataStore: MainPageDataStore?
}
