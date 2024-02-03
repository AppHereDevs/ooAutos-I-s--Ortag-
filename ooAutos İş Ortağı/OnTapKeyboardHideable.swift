//
//  OnTapKeyboardHideable.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 13.12.2023.
//

import UIKit

@objc protocol OnTapKeyboardHideable: AnyObject {
    @objc func hideKeyboard()
}

extension OnTapKeyboardHideable {
    func setupHideKeyboardOnTapRecognizer(in view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

extension OnTapKeyboardHideable where Self: UIViewController {
    func setupHideKeyboardOnTapRecognizer() { setupHideKeyboardOnTapRecognizer(in: view) }
}

extension UIViewController {
    @objc func hideKeyboard() { view.endEditing(true) }
}
