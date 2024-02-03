//
//  QRInteractor.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

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
                print(response)
                generateQRCode(from: response.decodedResponse.details.qrCode)
            case let .failure(error):
                print(error.localizedDescription)
                if error.requestDetails()?.statusCode == 401 {
                    presenter?.presentLogin()
                }
            }
        })
    }

    private func generateQRCode(from text: String?) {
        if let text {
            presenter?.generateQRCode(from: text)
        }
    }
}
