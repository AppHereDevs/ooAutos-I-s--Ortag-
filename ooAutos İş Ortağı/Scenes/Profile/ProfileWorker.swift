import CoreModule

protocol ProfileWorkerLogic {
    func getProfileInformation(completion: @escaping (Result<SuccessResult<ProfileModels.ServiceProviderInformation.Response>, NetworkError>) -> Void
    )
}
