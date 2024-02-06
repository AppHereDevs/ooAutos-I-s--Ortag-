import CoreModule

protocol ProfileWorkerLogic {
    func getProfileInformation(completion: @escaping (Result<SuccessResult<QRModels.ServiceProviderInformation.Response>, NetworkError>) -> Void
    )
}
