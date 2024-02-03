import CoreModule

public struct RestoreServiceProviderRequest: Request {
    public enum Request {
        case restoreService
    }

    public var request: RestoreServiceProviderRequest.Request
    public var apiEnvironment: ApiEnvironment

    public init(request: RestoreServiceProviderRequest.Request, apiEnvironment: ApiEnvironment) {
        self.request = request
        self.apiEnvironment = apiEnvironment
    }

    public var path: String {
        switch request {
        case .restoreService:
            return "restore-service-provider"
        }
    }

    public var httpMethod: HTTPMethods {
        switch request {
        case .restoreService:
            return .post
        }
    }

    public var urlParameters: Parameters? {
        nil
    }

    public var bodyParameters: Parameters? {
        switch request {
        case .restoreService:
            return nil
        }
    }

    public var httpHeaders: HTTPHeaders? {
        switch request {
        case .restoreService:
            var headers: HTTPHeaders = .init()
            headers["Accept-Language"] = "tr-TR"
            headers["Authorization"] = "Bearer \(UserDefaultsManager.shared.jwtToken.valueOrEmpty)"
            return headers
        }
    }
}
