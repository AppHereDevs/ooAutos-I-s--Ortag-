//
//  ServicesListPresenter.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct ConsumptionDetail {
    let plateNumber: String
    let consumeDate: String
    let consumeTime: String
    let price: String
    let serviceName: String
}

protocol ServicesListPresentationLogic {
    func presentConsumptionDetail(consumptionDetails: [ServicesListModels.ProviderConsumptionDetail.ConsumptionDetails])
}

class ServicesListPresenter: ServicesListPresentationLogic {

    // MARK: - Properties
    
    weak var viewController: ServicesListDisplayLogic?

    func presentConsumptionDetail(consumptionDetails: [ServicesListModels.ProviderConsumptionDetail.ConsumptionDetails]) {
        let presentableConsumptionDetails = consumptionDetails.map { ConsumptionDetail(plateNumber: $0.plateNumber ?? "-",
                                                                                       consumeDate: prepareConsumeDateToDisplay(date: $0.consumedAt).consumeDate,
                                                                                       consumeTime: prepareConsumeDateToDisplay(date: $0.consumedAt).consumeTime,
                                                                                       price: preparePriceToDisplay(price: $0.price),
                                                                                       serviceName: $0.serviceName ?? "-")}

        viewController?.displayConsumptionHistory(consumptionDetails: presentableConsumptionDetails)
    }

    private func prepareConsumeDateToDisplay(date: String?) -> (consumeDate: String, consumeTime: String) {
        if let date {
            return ("some", "some")
        } else {
            return ("-", "-")
        }
    }

    private func preparePriceToDisplay(price: Float?) -> String {
        if let price {
            String(price)
        } else {
            "-"
        }
    }
}
