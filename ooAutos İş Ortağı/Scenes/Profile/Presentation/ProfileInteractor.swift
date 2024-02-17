import UIKit

protocol ProfileBusinessLogic: AnyObject {
    func getProfileInfo()
}

protocol ProfileDataStore {}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    // MARK: - Properties

    var worker: ProfileWorkerLogic?
    var presenter: ProfilePresentationLogic?

    func getProfileInfo() {
        worker?.getProfileInformation(completion: { [weak self] result in
            guard let self else { return }

            if case let .success(response) = result {
                presenter?.presentData(response: response.decodedResponse.details)
            }
        })
    }
}
