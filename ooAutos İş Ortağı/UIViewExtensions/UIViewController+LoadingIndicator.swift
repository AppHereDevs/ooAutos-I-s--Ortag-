//
//  UIViewController+LoadingIndicator.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 24.01.2024.
//

import UIKit
extension UIViewController {
    func showLoadingIndicator(loadingIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            loadingIndicator.center = self.view.center
            self.view.addSubview(loadingIndicator)
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }

    func hideLoadingIndicator(loadingIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}
