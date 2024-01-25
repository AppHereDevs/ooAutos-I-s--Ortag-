//
//  ProfilePresenter.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProfilePresentationLogic {
    func presentLogin()
    func presentData(response: QRModels.ServiceProviderInformation.ServiceProviderDetails)
}

class ProfilePresenter: ProfilePresentationLogic {

    // MARK: - Properties
    weak var viewController: ProfileDisplayLogic?
    
    func presentLogin() {
        viewController?.displayLogin()
    }
    
    func presentData(response: QRModels.ServiceProviderInformation.ServiceProviderDetails) {
        let viewModel = ProfileModels.ViewModel(name: response.name ?? "",
                                                typeDesc: response.typeDescription ?? "",
                                                address: response.address ?? "",
                                                telephoneNo: response.telephoneNo ?? "",
                                                mobileNo: response.mobileNo ?? "",
                                                email: response.eMail ?? "",
                                                ibanNo: response.ibanNo ?? "",
                                                ibanName: response.ibanAccountName ?? "",
                                                workingHours: response.workingHours ?? "")
        viewController?.displayPersonalInfo(viewModel: viewModel)
    }
}
