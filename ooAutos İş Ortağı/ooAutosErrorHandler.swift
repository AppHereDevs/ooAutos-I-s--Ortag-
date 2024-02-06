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

    init(decoratee: T, errorDisplayer: LoginPageDisplayer & AlertDisplayer) {
        self.decoratee = decoratee
        self.errorDisplayer = errorDisplayer
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
                } else if let errorText = response.errors?.first {
                    errorDisplayer.presentAlert(alertTitle: errorText)
                } else {
                    errorDisplayer.presentAlert(alertTitle: "Bir hata olustu.")
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
