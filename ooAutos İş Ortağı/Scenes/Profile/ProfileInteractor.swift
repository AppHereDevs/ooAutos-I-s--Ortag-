//
//  ProfileInteractor.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProfileBusinessLogic: AnyObject {
    func getProfileInfo()
}

protocol ProfileDataStore {}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    // MARK: - Properties

    var worker: ProfileWorkerLogic?
    var presenter: ProfilePresentationLogic?

    func getProfileInfo() {
        worker?.getProfileInformation(completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                print(response)
                presenter?.presentData(response: response.decodedResponse.details)
            case let .failure(error):
                print(error.localizedDescription)
                if error.requestDetails()?.statusCode == 401 {
                    presenter?.presentLogin()
                }
            }
        })
    }
}
