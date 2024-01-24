import CoreModule

public struct ConsumptionDetailsRequest: Request {
    public enum Request {
        case consumptionDetail(startDate: String? = nil, endDate: String? = nil)
    }

    public var request: ConsumptionDetailsRequest.Request
    public var apiEnvironment: ApiEnvironment

    public init(request: ConsumptionDetailsRequest.Request, apiEnvironment: ApiEnvironment) {
        self.request = request
        self.apiEnvironment = apiEnvironment
    }
    
    public var path: String {
        switch request {
        case .consumptionDetail(let startDate, let endDate):
            if let startDate, let endDate {
                return "sp/consumption-details/All/\(startDate)/\(endDate)/"
            } else {
                return "sp/consumption-details/All/"
            }
        }
    }

    public var httpMethod: HTTPMethods {
        switch request {
        case .consumptionDetail:
            return .get
        }
    }

    public var urlParameters: Parameters? {
        nil
    }

    public var bodyParameters: Parameters? {
        switch request {
        case .consumptionDetail:
           return nil
        }
    }
    
    public var httpHeaders: HTTPHeaders? {
        switch request {
        case .consumptionDetail:
            var headers: HTTPHeaders = .init()
            headers["Accept-Language"] = "tr-TR"
            headers["Authorization"] = "Bearer \(UserDefaultsManager.shared.jwtToken.valueOrEmpty)"
            return headers
        }
    }
}


