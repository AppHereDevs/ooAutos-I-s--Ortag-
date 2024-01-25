//
//  ProfileViewController.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import AppHereComponents

protocol ProfileDisplayLogic: AnyObject {
    func displayLogin()
    func displayPersonalInfo(viewModel: ProfileModels.ViewModel)
}

class ProfileViewController: UIViewController, ProfileDisplayLogic {

    // MARK: - Properties
    
    @IBOutlet weak var name: AppHereInputView!
    @IBOutlet weak var typeDesc: AppHereInputView!
    @IBOutlet weak var adress: AppHereInputView!
    @IBOutlet weak var phoneNumber: AppHereInputView!
    @IBOutlet weak var mobileNumber: AppHereInputView!
    @IBOutlet weak var email: AppHereInputView!
    @IBOutlet weak var ibanNo: AppHereInputView!
    @IBOutlet weak var ibanAccountName: AppHereInputView!
    @IBOutlet weak var workingHours: AppHereInputView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var router: (NSObjectProtocol & ProfileRoutingLogic & ProfileDataPassing)?
    var interactor: ProfileBusinessLogic?
    private var worker: ProfileWorkerLogic?

    // MARK: - Object lifecycle
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }
    
    init() {
        super.init(nibName: nil, bundle: .main)
    }
    
    convenience init(worker: ProfileWorkerLogic) {
        self.init()
        self.worker = worker
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()

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
        setupBackgroundImage(imageName: "background")
        interactor?.getProfileInfo()
    }
    
    func displayPersonalInfo(viewModel: ProfileModels.ViewModel) {
        DispatchQueue.main.async {
            self.name.viewModel = AppHereInputViewModel(
                title: "İSİM",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 64)
            )
            self.name.inputTextField.text = viewModel.name
            self.name.isUserInteractionEnabled = false
            
            self.typeDesc.viewModel = AppHereInputViewModel(
                title: "TİPİ",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 64)
            )
            self.typeDesc.inputTextField.text = viewModel.typeDesc
            self.typeDesc.isUserInteractionEnabled = false
            
            self.adress.viewModel = AppHereInputViewModel(
                title: "ADRES",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 256)
            )
            self.adress.inputTextField.text = viewModel.address
            self.adress.isUserInteractionEnabled = false
            
            self.phoneNumber.viewModel = AppHereInputViewModel(
                title: "TELEFON NUMARASI",
                placeholder: "",
                keyboardType: .phonePad,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 64)
            )
            self.phoneNumber.inputTextField.text = viewModel.telephoneNo
            self.phoneNumber.isUserInteractionEnabled = false
            
            self.mobileNumber.viewModel = AppHereInputViewModel(
                title: "MOBİL NUMARASI",
                placeholder: "",
                keyboardType: .phonePad,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 64)
            )
            self.mobileNumber.inputTextField.text = viewModel.mobileNo
            self.mobileNumber.isUserInteractionEnabled = false
            
            self.email.viewModel = AppHereInputViewModel(
                title: "EMAİL",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 64)
            )
            self.email.inputTextField.text = viewModel.email
            self.email.isUserInteractionEnabled = false
            
            self.ibanNo.viewModel = AppHereInputViewModel(
                title: "IBAN NO",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 256)
            )
            self.ibanNo.inputTextField.text = viewModel.ibanNo
            self.ibanNo.isUserInteractionEnabled = false
            
            self.ibanAccountName.viewModel = AppHereInputViewModel(
                title: "HESAP BİLGİSİ",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 256)
            )
            self.ibanAccountName.inputTextField.text = viewModel.ibanName
            self.ibanAccountName.isUserInteractionEnabled = false
            
            self.workingHours.viewModel = AppHereInputViewModel(
                title: "ÇALIŞMA BİLGİSİ",
                placeholder: "",
                keyboardType: .default,
                validationModel: AppHereInputViewModel.ValidationModel(maxCharLength: 256)
            )
            self.workingHours.inputTextField.text = viewModel.workingHours
            self.workingHours.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        self.restartFromLogin()
    }
    
    func displayLogin() {
        self.restartFromLogin()
    }
    
}
