//
//  UIViewController+BackgroundImage.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 13.12.2023.
//

import UIKit

extension UIViewController {
    /// Setup background image.
    func setupBackgroundImage(imageName: String) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: imageName)
        backgroundImage.contentMode = .scaleToFill
        view.insertSubview(backgroundImage, at: 0)
    }
}
