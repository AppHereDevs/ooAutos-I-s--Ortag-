import UIKit

protocol MainPageBusinessLogic: AnyObject {
    func getProviderInformation()
    func getConsumptionInformation()
    func suspendServiceProvider()
    func restoreServiceProvider()
    func getConsumptionDetail(startDate: String?, endDate: String?)
}

class MainPageInteractor: MainPageBusinessLogic {
    // MARK: - Properties

    var worker: MainPageWorkerLogic?
    var presenter: MainPagePresentationLogic?

    func getProviderInformation() {
        worker?.getProviderInfo(completion: { [weak self] result in
            guard let self else { return }
            hideLoadingIndicator()

            if case let .success(response) = result {
                presenter?.presentProviderInfo(response: response.decodedResponse.details)
            }
        })
    }

    func getConsumptionInformation() {
        worker?.getConsumptionInfo(kind: "Daily") { [weak self] result in
            guard let self else { return }
            hideLoadingIndicator()

            if case let .success(response) = result {
                presenter?.presentDailyConsumption(consumptionAmount: response.decodedResponse.details.totalConsumptionCount)
            }
        }

        worker?.getConsumptionInfo(kind: "Monthly") { [weak self] result in
            guard let self else { return }
            hideLoadingIndicator()

            if case let .success(response) = result {
                presenter?.presentMonthlyConsumption(consumptionAmount: response.decodedResponse.details.totalConsumptionCount)
            }
        }

        worker?.getConsumptionInfo(kind: "Yearly") { [weak self] result in
            guard let self else { return }
            hideLoadingIndicator()

            if case let .success(response) = result {
                presenter?.presentYearlyConsumption(consumptionAmount: response.decodedResponse.details.totalConsumptionCount)
            }
        }
    }

    func suspendServiceProvider() {
        worker?.suspendProvider(completion: { [weak self] result in
            guard let self else { return }
            hideLoadingIndicator()

            switch result {
            case .success:
                presenter?.presentProviderStatus(with: false)
            case .failure:
                presenter?.presentProviderStatus(with: true)
            }
        })
    }

    func restoreServiceProvider() {
        worker?.restoreProvider(completion: { [weak self] result in
            guard let self else { return }
            hideLoadingIndicator()

            switch result {
            case .success:
                presenter?.presentProviderStatus(with: true)
            case .failure:
                presenter?.presentProviderStatus(with: false)
            }
        })
    }

    func getConsumptionDetail(startDate: String?, endDate: String?) {
        worker?.getConsumptionDetail(startDate: startDate, endDate: endDate, completion: { [weak self] result in
            guard let self else { return }
            hideLoadingIndicator()

            switch result {
            case let .success(response):
                presenter?.presentProviderStatus(with: true)
                presenter?.presentConsumptionDetail(details: response.decodedResponse.details)
            case .failure:
                presenter?.presentProviderStatus(with: false)
            }
        })
    }

    private func hideLoadingIndicator() {
        presenter?.hideLoadingIndicator()
    }
}
