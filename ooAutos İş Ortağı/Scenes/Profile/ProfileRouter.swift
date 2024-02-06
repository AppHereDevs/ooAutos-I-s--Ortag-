import UIKit

protocol ProfileRoutingLogic {}

protocol ProfileDataPassing {
    var dataStore: ProfileDataStore? { get }
}

class ProfileRouter: NSObject, ProfileRoutingLogic, ProfileDataPassing {
    // MARK: - Properties

    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?
}
