//
//  LoginInteractor.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 13.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoginBusinessLogic: AnyObject {
    func viewDidLoad()
    func authenticate(phoneNumber: String, password: String)
}

protocol LoginDataStore {}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {

    // MARK: - Properties

    var worker: LoginWorkerLogic?
    var presenter: LoginPresentationLogic?
    
    func viewDidLoad() {
        presenter?.presentInitialUI()
    }

    func authenticate(phoneNumber: String, password: String) {
        print(phoneNumber)

        let requestModel = Login.AuthenticateUseCase.Request(phoneNumber: phoneNumber, password: password)
        worker?.authenticate(requestModel: requestModel) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                if let jwtToken = response.decodedResponse.details.jwtToken {
                    UserDefaultsManager.shared.jwtToken = jwtToken
                    UserDefaultsManager.shared.phoneNumber = phoneNumber
                    UserDefaultsManager.shared.loginStatus = true
                    self.presenter?.presentMainPage()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

}
