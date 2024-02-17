import UIKit

public struct ConsumptionDetail {
    let plateNumber: String
    let consumeDate: String
    let consumeTime: String
    let price: String
    let serviceName: String
}

protocol ServicesListPresentationLogic {
    func presentConsumptionDetail(consumptionDetails: [ServicesListModels.ProviderConsumptionDetail.ConsumptionDetails])
}

protocol ConsumptionView: AnyObject {
    func displayConsumptionHistory(consumptionDetails: [ConsumptionDetail])
}

protocol LoginDisplayer: AnyObject {
    func displaylogin()
}

class ServicesListPresenter: ServicesListPresentationLogic {
    // MARK: - Properties

    var consumptionView: ConsumptionView?

    func presentConsumptionDetail(consumptionDetails: [ServicesListModels.ProviderConsumptionDetail.ConsumptionDetails]) {
        let presentableConsumptionDetails = consumptionDetails.map { ConsumptionDetail(plateNumber: $0.plateNumber ?? "-",
                                                                                       consumeDate: prepareConsumeDateToDisplay(dateString: $0.consumedAt).consumeDate,
                                                                                       consumeTime: prepareConsumeDateToDisplay(dateString: $0.consumedAt).consumeTime,
                                                                                       price: preparePriceToDisplay(price: $0.price),
                                                                                       serviceName: $0.serviceName ?? "-") }

        consumptionView?.displayConsumptionHistory(consumptionDetails: presentableConsumptionDetails)
    }

    private func prepareConsumeDateToDisplay(dateString: String?) -> (consumeDate: String, consumeTime: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        dateFormatter.locale = Locale(identifier: "TR")

        if let dateString, let date = dateFormatter.date(from: dateString) {
            let newDateFormatter = DateFormatter()
            newDateFormatter.locale = Locale(identifier: "TR")

            newDateFormatter.dateFormat = "dd/MM/yyyy"
            let formattedDate = newDateFormatter.string(from: date)

            newDateFormatter.dateFormat = "HH:mm"
            let formattedTime = newDateFormatter.string(from: date)

            return (formattedDate, formattedTime)
        } else {
            return ("-", "-")
        }
    }

    private func preparePriceToDisplay(price: Float?) -> String {
        if let price {
            String("\(price) ₺")
        } else {
            "-"
        }
    }
}
