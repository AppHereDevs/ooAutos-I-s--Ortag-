import CoreModule
import Foundation

final class MainQueueDispatchOperator<T> {
    private let decoratee: T

    init(decoratee: T) {
        self.decoratee = decoratee
    }

    func dispatch(completion: @escaping () -> Void) {
        if Thread.isMainThread {
            completion()
        } else {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}

extension MainQueueDispatchOperator: ServicesListWorkerLogic where T == ServicesListWorkerLogic {
    func getConsumptionDetail(startDate: String?, endDate: String?, completion: @escaping (Result<CoreModule.SuccessResult<ServicesListModels.ProviderConsumptionDetail.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.getConsumptionDetail(startDate: startDate, endDate: endDate) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainQueueDispatchOperator: MainPageWorkerLogic where T == MainPageWorkerLogic {
    func getProviderInfo(completion: @escaping (Result<CoreModule.SuccessResult<QRModels.ServiceProviderInformation.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.getProviderInfo { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }

    func getConsumptionInfo(kind: String, completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.ConsumptionInformation.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.getConsumptionInfo(kind: kind) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }

    func suspendProvider(completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.SuspendProvider.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.suspendProvider { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }

    func restoreProvider(completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.SuspendProvider.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.restoreProvider { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }

    func getConsumptionDetail(startDate: String?, endDate: String?, completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.ProviderConsumptionDetail.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.getConsumptionDetail(startDate: startDate, endDate: endDate) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainQueueDispatchOperator: LoginWorkerLogic where T == LoginWorkerLogic {
    func authenticate(requestModel: Login.AuthenticateUseCase.Request, completion: @escaping (Result<CoreModule.SuccessResult<Login.AuthenticateUseCase.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.authenticate(requestModel: requestModel) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainQueueDispatchOperator: QRWorkerLogic where T == QRWorkerLogic {
    func getInfo(completion: @escaping (Result<CoreModule.SuccessResult<QRModels.ServiceProviderInformation.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.getInfo() { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
