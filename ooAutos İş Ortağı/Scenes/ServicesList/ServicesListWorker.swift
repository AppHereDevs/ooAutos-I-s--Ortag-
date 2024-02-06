import CoreModule
import UIKit

public protocol ServicesListWorkerLogic {
    func getConsumptionDetail(startDate: String?, endDate: String?, completion: @escaping (Result<CoreModule.SuccessResult<ServicesListModels.ProviderConsumptionDetail.Response>, CoreModule.NetworkError>) -> Void)
}
