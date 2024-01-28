import ApiClient
import CoreModule

extension ApiClient: LoginWorkerLogic {
    func authenticate(
        requestModel: Login.AuthenticateUseCase.Request,
        completion: @escaping (Result<SuccessResult<Login.AuthenticateUseCase.Response>, NetworkError>) -> Void
    ) {
        let request = AuthenticationRequests(
            request: .authenticate(phoneNumber: requestModel.phoneNumber, password: requestModel.password),
            apiEnvironment: ApiEnvironment(environmentType: ooAutosNetworkEnvironment.prod)
        )
        self.request(request, completion: completion)
    }
}

extension ApiClient: MainPageWorkerLogic {
    
    func getConsumptionDetail(startDate: String?, endDate: String?, completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.ProviderConsumptionDetail.Response>, CoreModule.NetworkError>) -> Void) {
        let request = ConsumptionDetailsRequest(request: .consumptionDetail(startDate: startDate, endDate: endDate),
                                                 apiEnvironment: ApiEnvironment(environmentType: ooAutosNetworkEnvironment.rest))
        self.request(request, completion: completion)
    }
    
    func restoreProvider(completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.SuspendProvider.Response>, CoreModule.NetworkError>) -> Void) {
        let request = RestoreServiceProviderRequest(request: .restoreService,
                                                 apiEnvironment: ApiEnvironment(environmentType: ooAutosNetworkEnvironment.prod))
        self.request(request, completion: completion)
    }
    
    func suspendProvider(completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.SuspendProvider.Response>, CoreModule.NetworkError>) -> Void) {
        let request = SuspendServiceProviderRequest(request: .suspendService,
                                                 apiEnvironment: ApiEnvironment(environmentType: ooAutosNetworkEnvironment.prod))
        self.request(request, completion: completion)
    }
    
    func getConsumptionInfo(kind: String,
                            completion: @escaping (Result<CoreModule.SuccessResult<MainPageModels.ConsumptionInformation.Response>, CoreModule.NetworkError>) -> Void) {
        let request = ConsumptionInfoRequest(request: .getConsumptionInfo(kind: kind),
                                                 apiEnvironment: ApiEnvironment(environmentType: ooAutosNetworkEnvironment.rest))
        self.request(request, completion: completion)
    }
    
    func getProviderInfo(completion: @escaping (Result<CoreModule.SuccessResult<QRModels.ServiceProviderInformation.Response>, CoreModule.NetworkError>) -> Void) {
        let request = ServiceProviderInfoRequest(request: .getInfo,
                                                 apiEnvironment: ApiEnvironment(environmentType: ooAutosNetworkEnvironment.rest))
        self.request(request, completion: completion)
    }
}

extension ApiClient: ServicesListWorkerLogic {
    func getConsumptionDetail(startDate: String?, endDate: String?, completion: @escaping (Result<CoreModule.SuccessResult<ServicesListModels.ProviderConsumptionDetail.Response>, CoreModule.NetworkError>) -> Void) {

    }
}

extension ApiClient: QRWorkerLogic {
    func getInfo(completion: @escaping (Result<CoreModule.SuccessResult<QRModels.ServiceProviderInformation.Response>, CoreModule.NetworkError>) -> Void) {
        let request = ServiceProviderInfoRequest(request: .getInfo,
                                                 apiEnvironment: ApiEnvironment(environmentType: ooAutosNetworkEnvironment.rest))
        self.request(request, completion: completion)
    }
    
}

extension ApiClient: ProfileWorkerLogic {
    func getProfileInformation(completion: @escaping (Result<CoreModule.SuccessResult<QRModels.ServiceProviderInformation.Response>, CoreModule.NetworkError>) -> Void) {
        let request = ServiceProviderInfoRequest(request: .getInfo,
                                                 apiEnvironment: ApiEnvironment(environmentType: ooAutosNetworkEnvironment.rest))
        self.request(request, completion: completion)
    }
}
