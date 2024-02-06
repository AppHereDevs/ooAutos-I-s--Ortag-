import UIKit

protocol LoginBusinessLogic: AnyObject {
    func viewDidLoad()
    func authenticate(phoneNumber: String, password: String)
}

protocol LoginDataStore {}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    // MARK: - Properties

    var worker: LoginWorkerLogic?
    var presenter: LoginPresentationLogic?

    func viewDidLoad() {
        presenter?.presentInitialUI()
    }

    func authenticate(phoneNumber: String, password: String) {
        let requestModel = Login.AuthenticateUseCase.Request(phoneNumber: phoneNumber, password: password)
        worker?.authenticate(requestModel: requestModel) { [weak self] result in
            guard let self else { return }

            if case let .success(response) = result {
                if let jwtToken = response.decodedResponse.details.jwtToken {
                    UserDefaultsManager.shared.jwtToken = jwtToken
                    UserDefaultsManager.shared.phoneNumber = phoneNumber
                    UserDefaultsManager.shared.loginStatus = true
                    self.presenter?.presentMainPage()
                }
            }
        }
    }
}
