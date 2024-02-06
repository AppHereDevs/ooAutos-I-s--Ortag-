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
            if case let .success(response) = result {
                presenter?.presentConsumptionDetail(consumptionDetails: response.decodedResponse.details)
            }
        })
    }
}
