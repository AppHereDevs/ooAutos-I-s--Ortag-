//
//  MainPageInteractor.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainPageBusinessLogic: AnyObject {
    func getProviderInformation()
    func getConsumptionInformation()
    func suspendServiceProvider()
    func restoreServiceProvider()
    func getConsumptionDetail(startDate: String?, endDate: String?)
}

protocol MainPageDataStore {}

class MainPageInteractor: MainPageBusinessLogic, MainPageDataStore {
    
    // MARK: - Properties
    
    var worker: MainPageWorkerLogic?
    var presenter: MainPagePresentationLogic?

    func getProviderInformation() {
        worker?.getProviderInfo(completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                print(response)
                presenter?.presentUserInfo(response: response.decodedResponse.details)
            case let .failure(error):
                print(error.localizedDescription)
                if error.requestDetails()?.statusCode == 401 {
                    presenter?.presentLogin()
                }
            }
        })
    }
    
    func getConsumptionInformation() {
        var viewModel = MainPageModels.ConsumptionCountViewModel(daily: 0, monthly: 0, yearly: 0)
        worker?.getConsumptionInfo(kind: "Daily", completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                viewModel.daily = response.decodedResponse.details.totalConsumptionCount ?? 0
                worker?.getConsumptionInfo(kind: "Monthly", completion: { [weak self] result in
                    guard let self else { return }
                    switch result {
                    case let .success(response):
                        viewModel.monthly = response.decodedResponse.details.totalConsumptionCount ?? 0
                        worker?.getConsumptionInfo(kind: "Yearly", completion: { [weak self] result in
                            guard let self else { return }
                            switch result {
                            case let .success(response):
                                viewModel.yearly = response.decodedResponse.details.totalConsumptionCount ?? 0
                                
                            case let .failure(error):
                                print(error.localizedDescription)
                                if error.requestDetails()?.statusCode == 401 {
                                    presenter?.presentLogin()
                                }
                            }
                        })
                    case let .failure(error):
                        print(error.localizedDescription)
                        if error.requestDetails()?.statusCode == 401 {
                            presenter?.presentLogin()
                        }
                    }
                })
            case let .failure(error):
                print(error.localizedDescription)
                if error.requestDetails()?.statusCode == 401 {
                    presenter?.presentLogin()
                }
            }
        })
        presenter?.presentConsumptions(viewModel: viewModel)
    }
    
    func suspendServiceProvider() {
        worker?.suspendProvider(completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                presenter?.presentProviderStatus(with: false)
            case let .failure(error):
                print(error.localizedDescription)
                presenter?.presentProviderStatus(with: true)
                if error.requestDetails()?.statusCode == 401 {
                    presenter?.presentLogin()
                }
            }
        })
    }
    
    func restoreServiceProvider() {
        worker?.restoreProvider(completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                presenter?.presentProviderStatus(with: true)
            case let .failure(error):
                print(error.localizedDescription)
                presenter?.presentProviderStatus(with: false)
                if error.requestDetails()?.statusCode == 401 {
                    presenter?.presentLogin()
                }
            }
        })
    }
    
    func getConsumptionDetail(startDate: String?, endDate: String?) {
        worker?.getConsumptionDetail(startDate: startDate, endDate: endDate, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                if let firstItem = response.decodedResponse.details.first {
                    presenter?.presentConsumptionDetail(response: firstItem)
                }
                
            case let .failure(error):
                print(error.localizedDescription)
                presenter?.presentProviderStatus(with: false)
                if error.requestDetails()?.statusCode == 401 {
                    presenter?.presentLogin()
                }
            }
        })
    }
}
