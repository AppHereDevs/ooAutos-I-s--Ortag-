import CoreModule

public struct ConsumptionInfoRequest: Request {
    public enum Request {
        case getConsumptionInfo(kind: String)
    }

    public var request: ConsumptionInfoRequest.Request
    public var apiEnvironment: ApiEnvironment

    public init(request: ConsumptionInfoRequest.Request, apiEnvironment: ApiEnvironment) {
        self.request = request
        self.apiEnvironment = apiEnvironment
    }
    
    public var path: String {
        switch request {
        case .getConsumptionInfo(let kind):
            return "sp/consumption-summary/\(kind)"
        }
    }

    public var httpMethod: HTTPMethods {
        switch request {
        case .getConsumptionInfo:
            return .get
        }
    }

    public var urlParameters: Parameters? {
        nil
    }

    public var bodyParameters: Parameters? {
        switch request {
        case .getConsumptionInfo:
           return nil
        }
    }
    
    public var httpHeaders: HTTPHeaders? {
        switch request {
        case .getConsumptionInfo:
            var headers: HTTPHeaders = .init()
            headers["Accept-Language"] = "tr-TR"
            headers["Authorization"] = "Bearer \(UserDefaultsManager.shared.jwtToken.valueOrEmpty)"
            return headers
        }
    }
}


