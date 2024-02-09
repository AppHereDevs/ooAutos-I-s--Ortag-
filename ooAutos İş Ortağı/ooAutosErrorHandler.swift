import CoreModule
import Foundation

protocol LoginPageDisplayer {
    func presentLogin()
}

protocol AlertDisplayer {
    func presentAlert(alertTitle: String)
}

final class ooAutosErrorHandler<T> {
    private struct ooAutosErrorResponse: Decodable {
        let statusCode: Int
        let message: String
        let validationErrors: [ValidationErrorModel]?
        let errors: [String]?

        struct ValidationErrorModel: Decodable {
            let field: String
            let error: String
        }
    }

    private let decoratee: T
    private let errorDisplayer: LoginPageDisplayer & AlertDisplayer
    private let errorLogger: ErrorLogger

    init(decoratee: T, errorDisplayer: LoginPageDisplayer & AlertDisplayer, errorLogger: ErrorLogger) {
        self.decoratee = decoratee
        self.errorDisplayer = errorDisplayer
        self.errorLogger = errorLogger
    }

    func handleError(error: NetworkError) {
        if error.requestDetails()?.statusCode == 401 {
            errorDisplayer.presentLogin()
        } else {
            if
                let erroredRequestDetail = error.requestDetails(),
                let response = parseErrorResponse(responseData: erroredRequestDetail.errorResponseData!)
            {
                if let validationError = response.validationErrors?.first?.error {
                    errorDisplayer.presentAlert(alertTitle: validationError)

                    let errorLog: String = "Request to \(erroredRequestDetail.request.path) failed | Status Code: \(erroredRequestDetail.statusCode) | Error message: \(validationError) "
                    errorLogger.logError(errorMessage: errorLog)
                } else if let errorText = response.errors?.first {
                    errorDisplayer.presentAlert(alertTitle: errorText)

                    let errorLog: String = "Request to \(erroredRequestDetail.request.path) failed | Status Code: \(erroredRequestDetail.statusCode) | Error message: \(errorText) "
                    errorLogger.logError(errorMessage: errorLog)
                } else {
                    errorDisplayer.presentAlert(alertTitle: "Bir hata olustu.")

                    let errorLog: String = "Request to \(erroredRequestDetail.request.path) failed | Status Code: \(erroredRequestDetail.statusCode) | Error message: \(response.message) "
                    errorLogger.logError(errorMessage: errorLog)
                }

            } else {
                errorDisplayer.presentAlert(alertTitle: "Bir hata olustu.")
            }
        }
    }

    private func parseErrorResponse(responseData: Data) -> ooAutosErrorResponse? {
        guard let decodedResponse = try? JSONDecoder().decode(ooAutosErrorResponse.self, from: responseData) else {
            return nil
        }
        return decodedResponse
    }
}

extension ooAutosErrorHandler: ServicesListWorkerLogic where T == ServicesListWorkerLogic {
    func getConsumptionDetail(startDate: String?, endDate: String?, completion: @escaping (Result<CoreModule.SuccessResult<ServicesListModels.ProviderConsumptionDetail.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.getConsumptionDetail(startDate: startDate, endDate: endDate) { [weak self] result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                self?.handleError(error: error)
                completion(.failure(error))
            }
        }
    }
}

extension ooAutosErrorHandler: LoginWorkerLogic where T == LoginWorkerLogic {
    func authenticate(requestModel: Login.AuthenticateUseCase.Request, completion: @escaping (Result<CoreModule.SuccessResult<Login.AuthenticateUseCase.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.authenticate(requestModel: requestModel) { [weak self] result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                self?.handleError(error: error)
                completion(.failure(error))
            }
        }
    }
}

extension ooAutosErrorHandler: MainPageWorkerLogic where T == MainPageWorkerLogic {
    func getProviderInfo(completion: @escaping (Result<CoreModule.SuccessResult<QRModels.ServiceProviderInformation.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.getProviderInfo { [weak self] result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                self?.handleError(error: error)
                completion(.failure(error))
            }
        }
    }

    func getConsumptionInfo(kind: String, completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.ConsumptionInformation.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.getConsumptionInfo(kind: kind) { [weak self] result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                self?.handleError(error: error)
                completion(.failure(error))
            }
        }
    }

    func suspendProvider(completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.SuspendProvider.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.suspendProvider { [weak self] result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                self?.handleError(error: error)
                completion(.failure(error))
            }
        }
    }

    func restoreProvider(completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.SuspendProvider.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.restoreProvider { [weak self] result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                self?.handleError(error: error)
                completion(.failure(error))
            }
        }
    }

    func getConsumptionDetail(startDate: String?, endDate: String?, completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.ProviderConsumptionDetail.Response>, CoreModule.NetworkError>) -> Void) {
        decoratee.getConsumptionDetail(startDate: startDate, endDate: endDate) { [weak self] result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                self?.handleError(error: error)
                completion(.failure(error))
            }
        }
    }
}
