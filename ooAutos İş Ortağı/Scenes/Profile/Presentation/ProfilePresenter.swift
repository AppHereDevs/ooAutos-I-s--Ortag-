import UIKit

protocol ProfilePresentationLogic {
    func presentData(response: ProfileModels.ServiceProviderInformation.ServiceProviderDetails)
}

class ProfilePresenter: ProfilePresentationLogic {
    // MARK: - Properties

    weak var viewController: ProfileDisplayLogic?

    func presentData(response: ProfileModels.ServiceProviderInformation.ServiceProviderDetails) {
        let viewModel = ProfileModels.ViewModel(name: response.name ?? "",
                                                typeDesc: response.typeDescription ?? "",
                                                address: response.address ?? "",
                                                telephoneNo: response.telephoneNo ?? "",
                                                mobileNo: response.mobileNo ?? "",
                                                email: response.eMail ?? "",
                                                ibanNo: response.ibanNo ?? "",
                                                ibanName: response.ibanAccountName ?? "",
                                                workingHours: response.workingHours ?? "")
        viewController?.displayPersonalInfo(viewModel: viewModel)
    }
}
