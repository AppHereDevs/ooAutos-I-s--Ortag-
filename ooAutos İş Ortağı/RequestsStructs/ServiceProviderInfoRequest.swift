import CoreModule

public struct ServiceProviderInfoRequest: Request {
    public enum Request {
        case getInfo
    }

    public var request: ServiceProviderInfoRequest.Request
    public var apiEnvironment: ApiEnvironment

    public init(request: ServiceProviderInfoRequest.Request, apiEnvironment: ApiEnvironment) {
        self.request = request
        self.apiEnvironment = apiEnvironment
    }
    
    public var path: String {
        switch request {
        case .getInfo:
            return "sp/information/true"
        }
    }

    public var httpMethod: HTTPMethods {
        switch request {
        case .getInfo:
            return .get
        }
    }

    public var urlParameters: Parameters? {
        nil
    }

    public var bodyParameters: Parameters? {
        switch request {
        case .getInfo:
           return nil
        }
    }
    
    public var httpHeaders: HTTPHeaders? {
        switch request {
        case .getInfo:
            var headers: HTTPHeaders = .init()
            headers["Accept-Language"] = "tr-TR"
            headers["Authorization"] = "Bearer \(UserDefaultsManager.shared.jwtToken.valueOrEmpty)"
            return headers
        }
    }
}


