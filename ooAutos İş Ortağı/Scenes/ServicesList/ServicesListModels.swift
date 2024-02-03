//
//  ServicesListModels.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

public enum ServicesListModels {
    public enum ProviderConsumptionDetail {
        public struct Response: Decodable {
            let statusCode: Int
            let message: String
            let details: [ConsumptionDetails]
        }

        public struct ConsumptionDetails: Decodable {
            let plateNumber: String?
            let consumedAt: String?
            let price: Float?
            let serviceName: String?
        }
    }
}
