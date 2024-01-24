import CoreModule

public struct AuthenticationRequests: Request {
    public enum Request {
        case authenticate(phoneNumber: String, password: String)
    }

    public var request: AuthenticationRequests.Request
    public var apiEnvironment: ApiEnvironment

    public init(request: AuthenticationRequests.Request, apiEnvironment: ApiEnvironment) {
        self.request = request
        self.apiEnvironment = apiEnvironment
    }
    
    public var path: String {
        switch request {
        case .authenticate:
            return "authenticate-service-provider"
        }
    }

    public var httpMethod: HTTPMethods {
        switch request {
        case .authenticate:
            return .post
        }
    }

    public var urlParameters: Parameters? {
        nil
    }

    public var bodyParameters: Parameters? {
        switch request {
        case let .authenticate(phoneNumber, password):
            var bodyParameters: Parameters = .init()
            bodyParameters["PhoneNumber"] = phoneNumber
            bodyParameters["Password"] = password
            return bodyParameters
        }
    }

    public var httpHeaders: HTTPHeaders? {
        switch request {
        case .authenticate:
            var headers: HTTPHeaders = .init()
            headers["Accept-Language"] = "tr-TR"
            return headers
        }
    }
}
