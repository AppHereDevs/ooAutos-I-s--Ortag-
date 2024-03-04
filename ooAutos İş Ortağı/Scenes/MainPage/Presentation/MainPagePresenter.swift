import UIKit

protocol MainPagePresentationLogic {
    func presentProviderInfo(response: QRModels.ServiceProviderInformation.ServiceProviderDetails)
    func presentProviderStatus(with status: Bool)
    func presentConsumptionDetail(details: [MainPageModels.ProviderConsumptionDetail.ConsumptionDetails])

    func presentDailyConsumption(consumptionAmount: Int?)
    func presentMonthlyConsumption(consumptionAmount: Int?)
    func presentYearlyConsumption(consumptionAmount: Int?)

    func hideLoadingIndicator()
}

class MainPagePresenter: MainPagePresentationLogic {
    // MARK: - Properties

    weak var viewController: MainPageDisplayLogic?

    func presentProviderInfo(response: QRModels.ServiceProviderInformation.ServiceProviderDetails) {
        let providerViewModel = MainPageModels.ProviderViewModel(name: response.name ?? "",
                                                                 isOpenNow: response.isOpenNow ?? false,
                                                                 rating: "\(response.rating ?? 0.0) ★")
        viewController?.displayProviderInfo(providerViewModel: providerViewModel)
    }

    func presentDailyConsumption(consumptionAmount: Int?) {
        if let consumptionAmount {
            viewController?.displayDailyConsumption(consumptionAmount: String(consumptionAmount))
        } else {
            viewController?.displayDailyConsumption(consumptionAmount: "-")
        }
    }

    func presentMonthlyConsumption(consumptionAmount: Int?) {
        if let consumptionAmount {
            viewController?.displayMonthlyConsumption(consumptionAmount: String(consumptionAmount))
        } else {
            viewController?.displayMonthlyConsumption(consumptionAmount: "-")
        }
    }

    func presentYearlyConsumption(consumptionAmount: Int?) {
        if let consumptionAmount {
            viewController?.displayYearlyConsumption(consumptionAmount: String(consumptionAmount))
        } else {
            viewController?.displayYearlyConsumption(consumptionAmount: "-")
        }
    }

    func presentProviderStatus(with status: Bool) {
        viewController?.displayProviderStatus(with: status)
    }

    func presentConsumptionDetail(details: [MainPageModels.ProviderConsumptionDetail.ConsumptionDetails]) {
        if let lastConsumptionDetail = details.first {
            var formattedDate = ""
            var formattedTime = ""
            if let dateString = lastConsumptionDetail.consumedAt {
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
            viewController?.displayConsumptionDetail(consumptionDetailViewModel: MainPageModels.ConsumptionDetailViewModel(plate: lastConsumptionDetail.plateNumber ?? "",
                                                                                                                           time: formattedTime,
                                                                                                                           date: formattedDate))
        } else {
            viewController?.displayConsumptionHistoryNotAvailable(errorText: "Yıkama hareketi bilgisi bulunmuyor.")
        }
    }

    func hideLoadingIndicator() {
        viewController?.hideLoadingIndicator()
    }
}
