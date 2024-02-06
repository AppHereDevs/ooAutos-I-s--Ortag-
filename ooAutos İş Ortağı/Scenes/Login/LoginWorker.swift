import CoreModule

protocol LoginWorkerLogic {
    func authenticate(
        requestModel: Login.AuthenticateUseCase.Request,
        completion: @escaping (Result<SuccessResult<Login.AuthenticateUseCase.Response>, NetworkError>) -> Void
    )
}
