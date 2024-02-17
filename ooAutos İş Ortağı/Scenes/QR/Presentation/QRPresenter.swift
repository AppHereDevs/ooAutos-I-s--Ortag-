import UIKit

protocol QRPresentationLogic {
    func generateQRCode(from text: String)
}

class QRPresenter: QRPresentationLogic {
    // MARK: - Properties

    weak var viewController: QRDisplayLogic?

    func generateQRCode(from text: String) {
        let data = text.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                let qrCodeImage = UIImage(ciImage: output)
                viewController?.displayQRCode(image: qrCodeImage, stringQR: text)
            }
        }
    }
}
