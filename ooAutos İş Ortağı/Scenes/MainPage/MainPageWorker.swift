//
//  MainPageWorker.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import CoreModule

protocol MainPageWorkerLogic {
    func getProviderInfo(completion: @escaping (Result<SuccessResult<QRModels.ServiceProviderInformation.Response>, NetworkError>) -> Void
    )

    func getConsumptionInfo(kind: String, completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.ConsumptionInformation.Response>, CoreModule.NetworkError>) -> Void)

    func suspendProvider(completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.SuspendProvider.Response>, CoreModule.NetworkError>) -> Void)

    func restoreProvider(completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.SuspendProvider.Response>, CoreModule.NetworkError>) -> Void)
    func getConsumptionDetail(startDate: String?, endDate: String?, completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.ProviderConsumptionDetail.Response>, CoreModule.NetworkError>) -> Void)
}
