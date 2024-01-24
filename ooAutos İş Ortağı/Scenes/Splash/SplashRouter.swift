//
//  SplashRouter.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 13.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import ApiClient

protocol SplashRoutingLogic {
    func routeToLogin()
    func routeToMainPage()
}

protocol SplashDataPassing {
    var dataStore: SplashDataStore? { get }
}

class SplashRouter: NSObject, SplashRoutingLogic, SplashDataPassing {

    // MARK: - Properties

    weak var viewController: SplashViewController?
    var dataStore: SplashDataStore?

    // MARK: - Routing
    func routeToLogin() {
        let loginViewController = LoginViewController(worker: ApiClient.shared)
        viewController?.navigationController?.viewControllers = [loginViewController]
    }
    
    func routeToMainPage() {
        let mainViewController = CustomTabBarController.instantiate()
        viewController?.navigationController?.viewControllers = [mainViewController]
    }

}
