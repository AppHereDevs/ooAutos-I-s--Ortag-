import UIKit

protocol QRBusinessLogic: AnyObject {
    func getQRInformation()
}

protocol QRDataStore {}

class QRInteractor: QRBusinessLogic, QRDataStore {
    // MARK: - Properties

    var worker: QRWorkerLogic?
    var presenter: QRPresentationLogic?

    func getQRInformation() {
        worker?.getInfo(completion: { [weak self] result in
            guard let self else { return }

            if case let .success(response) = result {
                presenter?.generateQRCode(from: response.decodedResponse.details.qrCode)
            }
        })
    }
}
