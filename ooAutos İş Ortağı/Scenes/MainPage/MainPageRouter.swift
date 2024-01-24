//
//  MainPageRouter.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainPageRoutingLogic {}

protocol MainPageDataPassing {
    var dataStore: MainPageDataStore? { get }
}

class MainPageRouter: NSObject, MainPageRoutingLogic, MainPageDataPassing {

    // MARK: - Properties

    weak var viewController: MainPageViewController?
    var dataStore: MainPageDataStore?
}
