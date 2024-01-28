//
//  ServicesListModels.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum ServicesListModels {
    enum ProviderConsumptionDetail {
        struct Response: Decodable {
            let statusCode: Int
            let message: String
            let count: Int
            let details: [ConsumptionDetails]
        }

        struct ConsumptionDetails: Decodable {
            let plateNumber: String?
            let consumedAt: String?
            let price: Float?
            let serviceName: String?
        }
    }
}
