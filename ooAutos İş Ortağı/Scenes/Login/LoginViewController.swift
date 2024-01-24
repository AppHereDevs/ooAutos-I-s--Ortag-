//
//  LoginViewController.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 13.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import AppHereComponents

protocol LoginDisplayLogic: AnyObject {
    func displayInitialState(viewModel: Login.ViewModel)
    func navigateToMainPage()
}

class LoginViewController: UIViewController, LoginDisplayLogic, OnTapKeyboardHideable {

    // MARK: - Properties
    
    var userInputtables: [UserInputtable] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var informationView: AppHereInformationView!
    @IBOutlet weak var phoneNumberInputView: AppHereInputView!
    @IBOutlet weak var passwordInputView: AppHereInputView!
    @IBOutlet weak var continueButton: AppHereButton!
    @IBOutlet weak var continueButtonHeight: NSLayoutConstraint!
    
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    var interactor: LoginBusinessLogic?
    private var worker: LoginWorkerLogic?

    // MARK: - Object lifecycle
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }
    
    init() {
        super.init(nibName: nil, bundle: .main)
    }
    
    convenience init(worker: LoginWorkerLogic) {
        self.init()
        self.worker = worker
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputView.inputTextField.isSecureTextEntry = true
        setupBackgroundImage(imageName: "background")
        
        setupHideKeyboardOnTapRecognizer()
        setupKeyboardHandlers()
        setupViewControllerConfiguration()
        if #available(iOS 13.0, *) {
            phoneNumberInputView.inputTextField.overrideUserInterfaceStyle = .light
            passwordInputView.inputTextField.overrideUserInterfaceStyle = .light
        }
        interactor?.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        continueButtonHeight.constant = 50 + view.safeAreaInsets.bottom
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    /// Setup view configuration values.
    private func setupViewControllerConfiguration() {
        userInputtables.append(contentsOf: [phoneNumberInputView, passwordInputView])
    }

    
    
    private func setupKeyboardHandlers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    // MARK: - Keyboard functionality

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = view.convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }

    @objc private func keyboardWillHide(notification _: NSNotification) {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    
    func displayInitialState(viewModel: Login.ViewModel) {
        informationView.viewModel = viewModel.informationViewModel
        phoneNumberInputView.viewModel = viewModel.phoneNumberInputViewModel
        passwordInputView.viewModel = viewModel.passwordInputViewModel
        passwordInputView.inputTextField.enablePasswordToggle()
        continueButton.setTitle(viewModel.continueButtonTitle, for: .normal)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        checkUserInputs { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.interactor?.authenticate(
                phoneNumber: phoneNumberInputView.inputTextField.text.valueOrEmpty.nonSpaceString,
                password: passwordInputView.inputTextField.text.valueOrEmpty
            )
        }
    }
    
    // MARK: LoginDisplayLogic

    func navigateToMainPage() {
        DispatchQueue.main.async {
            self.router?.routeToMainPage()
        }
    }
    
    func checkUserInputs(completion: () -> Void) {
        var shouldProceed = true

        userInputtables.forEach { component in
            if component.isValidInput {
                component.hideError()
            } else {
                shouldProceed = false
                component.showError()
            }
        }

        guard shouldProceed else { return }
        completion()
    }

}
