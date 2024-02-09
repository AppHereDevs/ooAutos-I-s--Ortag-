import os

protocol ErrorLogger {
    func logError(errorMessage: String)
}

final class OSErrorLogger: ErrorLogger {
    func logError(errorMessage: String) {
        os_log(
            .fault,
            "%{public}s ",
            errorMessage
        )
    }
}
