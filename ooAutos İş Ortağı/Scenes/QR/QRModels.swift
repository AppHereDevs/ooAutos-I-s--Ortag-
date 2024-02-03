//
//  QRModels.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum QRModels {
    // MARK: - Use Cases

    enum ServiceProviderInformation {
        struct Response: Decodable {
            let message: String
            let details: ServiceProviderDetails
        }

        struct ServiceProviderDetails: Decodable {
            let id: Int?
            let name: String?
            let type: Int?
            let typeDescription: String?
            let address: String?
            let telephoneNo: String?
            let mobileNo: String?
            let eMail: String?
            let qrCode: String
            let ibanNo: String?
            let ibanAccountName: String?
            let workingHours: String?
            let isOpenNow: Bool?
            let rating: Float?
            let latitude: Double?
            let longitude: Double?
        }
    }
}
