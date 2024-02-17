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
            switch result {
            case let .success(response):
                presenter?.generateQRCode(from: response.decodedResponse.details.qrCode)
            case let .failure(error):
                if error.requestDetails()?.statusCode == 401 {
                    presenter?.presentLogin()
                }
            }
        })
    }
}
