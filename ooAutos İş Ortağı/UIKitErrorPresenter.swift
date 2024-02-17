import SwiftMessages
import UIKit

final class UIKitErrorPresenter: AlertDisplayer {
    private let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func presentAlert(alertTitle: String) {
        var config = SwiftMessages.Config()
        config.presentationStyle = .center
        config.duration = .seconds(seconds: 5)
        config.interactiveHide = true

        SwiftMessages.show(config: config) {
            let view = MessageView.viewFromNib(layout: .cardView)
            view.backgroundHeight = 150
            view.configureContent(
                title: alertTitle,
                body: nil,
                iconImage: nil,
                iconText: nil,
                buttonImage: nil,
                buttonTitle: "Tamam",
                buttonTapHandler: { _ in
                    SwiftMessages.hide()
                }
            )
            // Theme message elements with the warning style.
            view.configureTheme(.error)

            // Add a drop shadow.
            view.configureDropShadow()

            return view
        }
    }
}
