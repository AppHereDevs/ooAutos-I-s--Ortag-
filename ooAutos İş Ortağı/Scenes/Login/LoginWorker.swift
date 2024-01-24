//
//  LoginWorker.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 13.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import CoreModule

protocol LoginWorkerLogic {
    func authenticate(
        requestModel: Login.AuthenticateUseCase.Request,
        completion: @escaping (Result<SuccessResult<Login.AuthenticateUseCase.Response>, NetworkError>) -> Void
    )
}
