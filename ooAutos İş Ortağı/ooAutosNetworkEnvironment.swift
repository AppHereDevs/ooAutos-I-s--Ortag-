import CoreModule
import Foundation

enum ooAutosNetworkEnvironment: NetworkEnvironment {
    case prod
    case rest

    var baseURL: String {
        switch self {
        case .prod:
            if Config.appConfiguration == .TestFlight || Config.appConfiguration == .Debug {
                return "https://testwa.ooautos.com/api/mobile"
            } else {
                return "https://wa.ooautos.com/api/mobile"
            }

        case .rest:
            if Config.appConfiguration == .TestFlight || Config.appConfiguration == .Debug {
                return "https://testwa.ooautos.com/rest/mobile"
            } else {
                return "https://wa.ooautos.com/rest/mobile"
            }
        }
    }
}

enum AppConfiguration {
    case Debug
    case TestFlight
    case AppStore
}

enum Config {
    // This is private because the use of 'appConfiguration' is preferred.
    private static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"

    // This can be used to add debug statements.
    static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }

    static var appConfiguration: AppConfiguration {
        if isDebug {
            return .Debug
        } else if isTestFlight {
            return .TestFlight
        } else {
            return .AppStore
        }
    }
}
