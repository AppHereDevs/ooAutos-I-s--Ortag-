//
//  LoginRouter.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 13.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoginRoutingLogic {
    func routeToLogin()
    func routeToMainPage()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {

    // MARK: - Properties

    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    func routeToMainPage() {
        let mainViewController = CustomTabBarController.instantiate()
        viewController?.navigationController?.viewControllers = [mainViewController]
    }

    func routeToLogin() {
        let loginViewController = LoginViewController()
        viewController?.navigationController?.viewControllers = [loginViewController]
    }

}
