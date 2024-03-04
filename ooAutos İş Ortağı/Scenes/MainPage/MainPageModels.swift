import UIKit

enum MainPageModels {
    struct ConsumptionDetailViewModel {
        var plate: String
        var time: String
        var date: String
    }

    struct ConsumptionCountViewModel {
        var daily: Int
        var monthly: Int
        var yearly: Int
    }

    struct ProviderViewModel {
        let name: String
        let isOpenNow: Bool
        let rating: String
    }

    enum ConsumptionInformation {
        struct Response: Decodable {
            let message: String
            let details: ConsumptionDetails
        }

        struct ConsumptionDetails: Decodable {
            let periodStart: String?
            let periodFinish: String?
            let totalConsumptionCount: Int?
            let billedConsumptionCount: Int?
            let totalConsumptionAmount: Double?
            let billedConsumptionAmount: Double?
        }
    }

    enum SuspendProvider {
        struct Response: Decodable {
            let statusCode: Int
            let message: String
        }
    }

    enum ProviderConsumptionDetail {
        struct Response: Decodable {
            let statusCode: Int
            let message: String
            let details: [ConsumptionDetails]
        }

        struct ConsumptionDetails: Decodable {
            let plateNumber: String?
            let consumedAt: String?
            let price: Float?
            let serviceName: String?
        }
    }
}
