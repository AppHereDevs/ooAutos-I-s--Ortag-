//
//  QRRouter.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol QRRoutingLogic {
}

protocol QRDataPassing {
    var dataStore: QRDataStore? { get }
}

class QRRouter: NSObject, QRRoutingLogic, QRDataPassing {

    // MARK: - Properties

    weak var viewController: QRViewController?
    var dataStore: QRDataStore?

    // MARK: - Routing
}
