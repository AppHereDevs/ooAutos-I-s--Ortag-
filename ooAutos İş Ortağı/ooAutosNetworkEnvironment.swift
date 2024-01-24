import CoreModule

enum ooAutosNetworkEnvironment: NetworkEnvironment {
    case prod
    case rest

    var baseURL: String {
        switch self {
        case .prod: return "https://testwa.ooautos.com/api/mobile"
        case .rest: return "https://testwa.ooautos.com/rest/mobile"
        }
    }
}
