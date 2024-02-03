//
//  LoginModels.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 13.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import AppHereComponents

enum Login {
    struct ViewModel {
        let informationViewModel: AppHereInformationViewModel
        let phoneNumberInputViewModel: AppHereInputViewModel
        let passwordInputViewModel: AppHereInputViewModel
        let continueButtonTitle: String
        let registerButtonTitle: String
        let forgotPasswordButtonTitle: String
    }

    enum AuthenticateUseCase {
        struct Request {
            let phoneNumber: String
            let password: String
        }

        struct Response: Decodable {
            let details: AuthenticateDetailsModel
        }

        struct AuthenticateDetailsModel: Decodable {
            let jwtToken: String?
            let jwtTokenValidUntil: String?
        }
    }
}
