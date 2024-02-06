import AppHereComponents
import UIKit

protocol LoginPresentationLogic {
    func presentInitialUI()
    func presentMainPage()
}

class LoginPresenter: LoginPresentationLogic {
    // MARK: - Properties

    weak var viewController: LoginDisplayLogic?

    func presentInitialUI() {
        let viewModel = Login.ViewModel(
            informationViewModel: AppHereInformationViewModel(
                firstInformationText: "Giriş Yap",
                secondInformationText: "Telefon numaranız ile giriş yapın."
            ),
            phoneNumberInputViewModel: AppHereInputViewModel(
                title: "TELEFON NUMARASI",
                phoneLabelText: "+90",
                errorLabelText: "Telefon numaranızı doğru girin.",
                placeholder: "Telefon numaranızı girin.",
                keyboardType: .phonePad,
                validationModel: AppHereInputViewModel
                    .ValidationModel(
                        patternType: .phoneNumberWithSpace
                    )
            ),
            passwordInputViewModel: AppHereInputViewModel(
                title: "ŞİFRE",
                errorLabelText: "Şifrenizi doğru girin.",
                placeholder: "Şifrenizi girin.",
                keyboardType: .default,
                validationModel: AppHereInputViewModel
                    .ValidationModel(
                        patternType: .none
                    )
            ),
            continueButtonTitle: "Devam Et",
            registerButtonTitle: "Kayıt Ol",
            forgotPasswordButtonTitle: "Şifremi Unuttum"
        )
        viewController?.displayInitialState(viewModel: viewModel)
    }

    func presentMainPage() {
        viewController?.navigateToMainPage()
    }
}
