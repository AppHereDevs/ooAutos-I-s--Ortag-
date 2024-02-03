import CoreModule

public struct SuspendServiceProviderRequest: Request {
    public enum Request {
        case suspendService
    }

    public var request: SuspendServiceProviderRequest.Request
    public var apiEnvironment: ApiEnvironment

    public init(request: SuspendServiceProviderRequest.Request, apiEnvironment: ApiEnvironment) {
        self.request = request
        self.apiEnvironment = apiEnvironment
    }

    public var path: String {
        switch request {
        case .suspendService:
            return "suspend-service-provider"
        }
    }

    public var httpMethod: HTTPMethods {
        switch request {
        case .suspendService:
            return .post
        }
    }

    public var urlParameters: Parameters? {
        nil
    }

    public var bodyParameters: Parameters? {
        switch request {
        case .suspendService:
            return nil
        }
    }

    public var httpHeaders: HTTPHeaders? {
        switch request {
        case .suspendService:
            var headers: HTTPHeaders = .init()
            headers["Accept-Language"] = "tr-TR"
            headers["Authorization"] = "Bearer \(UserDefaultsManager.shared.jwtToken.valueOrEmpty)"
            return headers
        }
    }
}
