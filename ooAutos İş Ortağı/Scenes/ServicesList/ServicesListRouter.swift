//
//  ServicesListRouter.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ServicesListRoutingLogic {
}

protocol ServicesListDataPassing {
    var dataStore: ServicesListDataStore? { get }
}

class ServicesListRouter: NSObject, ServicesListRoutingLogic, ServicesListDataPassing {
    
    // MARK: - Properties
    
    weak var viewController: ServicesListViewController?
    var dataStore: ServicesListDataStore?
    
    // MARK: - Routing
    
}
