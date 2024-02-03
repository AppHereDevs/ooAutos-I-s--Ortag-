//
//  ServicesListInteractor.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

public protocol ServicesListBusinessLogic: AnyObject {
    func getConsumptionDetail(startDate: String?, endDate: String?)
}

class ServicesListInteractor: ServicesListBusinessLogic {
    // MARK: - Properties

    var worker: ServicesListWorkerLogic?
    var presenter: ServicesListPresentationLogic?

    func getConsumptionDetail(startDate: String?, endDate: String?) {
        worker?.getConsumptionDetail(startDate: startDate, endDate: endDate, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                presenter?.presentConsumptionDetail(consumptionDetails: response.decodedResponse.details)
            case let .failure(error):
                if error.requestDetails()?.statusCode == 401 {
                    presenter?.presentLogin()
                }
            }
        })
    }
}
