import UIKit

protocol QRRoutingLogic {}

protocol QRDataPassing {
    var dataStore: QRDataStore? { get }
}

class QRRouter: NSObject, QRRoutingLogic, QRDataPassing {
    // MARK: - Properties

    weak var viewController: QRViewController?
    var dataStore: QRDataStore?

    // MARK: - Routing
}
