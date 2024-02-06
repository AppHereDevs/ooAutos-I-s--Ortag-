import CoreModule

protocol QRWorkerLogic {
    func getInfo(completion: @escaping (Result<SuccessResult<QRModels.ServiceProviderInformation.Response>, NetworkError>) -> Void
    )
}
