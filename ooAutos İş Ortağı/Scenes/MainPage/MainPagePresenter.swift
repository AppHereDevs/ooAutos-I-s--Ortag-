import UIKit

protocol MainPagePresentationLogic {
    func presentLogin()
    func presentUserInfo(response: QRModels.ServiceProviderInformation.ServiceProviderDetails)
    func presentConsumptions(viewModel: MainPageModels.ConsumptionCountViewModel)
    func presentProviderStatus(with status: Bool)
    func presentConsumptionDetail(response: MainPageModels.ProviderConsumptionDetail.ConsumptionDetails)
}

class MainPagePresenter: MainPagePresentationLogic {
    // MARK: - Properties

    weak var viewController: MainPageDisplayLogic?

    func presentLogin() {
        viewController?.displayLogin()
    }

    func presentUserInfo(response: QRModels.ServiceProviderInformation.ServiceProviderDetails) {
        let providerViewModel = MainPageModels.ProviderViewModel(name: response.name ?? "",
                                                                 isOpenNow: response.isOpenNow ?? false,
                                                                 rating: "\(response.rating ?? 0.0) ★")
        viewController?.displayUserInfo(providerViewModel: providerViewModel)
    }

    func presentConsumptions(viewModel: MainPageModels.ConsumptionCountViewModel) {
        viewController?.displayConsumption(consumptionViewModel: viewModel)
    }

    func presentProviderStatus(with status: Bool) {
        viewController?.displayProviderStatus(with: status)
    }

    func presentConsumptionDetail(response: MainPageModels.ProviderConsumptionDetail.ConsumptionDetails) {
        var formattedDate = ""
        var formattedTime = ""
        if let dateString = response.consumedAt {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "TR")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"

            if let date = dateFormatter.date(from: dateString) {
                let newDateFormatter = DateFormatter()
                newDateFormatter.locale = Locale(identifier: "TR")
                newDateFormatter.dateFormat = "dd/MM/yyyy"
                formattedDate = newDateFormatter.string(from: date)
                newDateFormatter.dateFormat = "HH:mm"
                formattedTime = newDateFormatter.string(from: date)
            }
        }
        viewController?.displayConsumptionDetail(consumptionDetailViewModel: MainPageModels.ConsumptionDetailViewModel(plate: response.plateNumber ?? "",
                                                                                                                       time: formattedTime,
                                                                                                                       date: formattedDate))
    }
}
