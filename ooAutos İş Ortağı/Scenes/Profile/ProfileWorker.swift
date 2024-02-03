//
//  ProfileWorker.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import CoreModule

protocol ProfileWorkerLogic {
    func getProfileInformation(completion: @escaping (Result<SuccessResult<QRModels.ServiceProviderInformation.Response>, NetworkError>) -> Void
    )
}
