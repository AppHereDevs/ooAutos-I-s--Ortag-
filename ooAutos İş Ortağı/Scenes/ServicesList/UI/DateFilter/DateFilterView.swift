import AppHereComponents
import SwiftMessages
import UIKit

class DateFilterView: MessageView, UITextFieldDelegate {
    @IBOutlet private var startDateTextField: AppHereTextField!
    @IBOutlet private var endDateTextField: AppHereTextField!
    @IBOutlet private var applyFilterButton: AppHereButton!
    @IBOutlet private var clearFilterButton: AppHereButton!
    @IBOutlet private var endDateLabel: UILabel!

    private var startDatePicker = UIDatePicker()
    private var endDatePicker = UIDatePicker()

    private static let userCalendar = Calendar(identifier: .gregorian)
    private static let minimumDateComponents = DateComponents(timeZone: TimeZone(abbreviation: "TR"), year: 2023, month: 1, day: 1)
    private let minimumDate: Date = userCalendar.date(from: minimumDateComponents)!

    var applyFilterButtonAction: ((_ startDate: String, _ endDate: String) -> Void)?
    var clearFilterButtonAction: (() -> Void)?

    override func awakeFromNib() {
        startDateTextField.delegate = self
        endDateTextField.delegate = self

        applyFilterButton.isUserInteractionEnabled = false
        applyFilterButton.alpha = 0.5

        setupStartDateSelection()
        setupStartDatePicker()
    }

    private func setupStartDateSelection() {
        startDateTextField.text = ""
        startDateTextField.placeholder = "Tarih seçiniz."

        disableEndDateSelection()
    }

    private func setupStartDatePicker(maximumDate: Date = .now) {
        startDatePicker.datePickerMode = .date
        startDatePicker.minimumDate = minimumDate
        startDatePicker.maximumDate = maximumDate

        if #available(iOS 13.4, *) {
            startDatePicker.preferredDatePickerStyle = .wheels
        }

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Onayla",
            style: .plain,
            target: self,
            action: #selector(startDateSelectionComplete)
        )
        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil
        )

        toolbar.setItems([spaceButton, doneButton], animated: false)
        startDateTextField.inputAccessoryView = toolbar
        startDateTextField.inputView = startDatePicker
    }

    @objc private func startDateSelectionComplete() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        startDateTextField.text = formatter.string(from: startDatePicker.date)
        endEditing(true)

        updateApplyFilterButtonStatus()
        setupEndDatePicker(minimumDate: startDatePicker.date)
        enableEndDateSelection()
    }

    private func updateApplyFilterButtonStatus() {
        if let startDate = startDateTextField.text, let endDate = endDateLabel.text {
            applyFilterButton.isUserInteractionEnabled = true
            applyFilterButton.alpha = 1
        } else {
            applyFilterButton.isUserInteractionEnabled = false
            applyFilterButton.alpha = 0.5
        }
    }

    private func disableEndDateSelection() {
        endDateTextField.isUserInteractionEnabled = false
        endDateTextField.alpha = 0.5
        endDateTextField.placeholder = "Tarih seçiniz"

        endDateLabel.isUserInteractionEnabled = false
        endDateLabel.alpha = 0.5
    }

    private func enableEndDateSelection() {
        endDateTextField.isUserInteractionEnabled = true
        endDateTextField.alpha = 1
        endDateTextField.placeholder = "Tarih seçiniz"

        endDateLabel.isUserInteractionEnabled = true
        endDateLabel.alpha = 1
    }

    private func setupEndDatePicker(minimumDate: Date) {
        endDatePicker.datePickerMode = .date
        endDatePicker.minimumDate = minimumDate
        endDatePicker.maximumDate = .now

        if #available(iOS 13.4, *) {
            endDatePicker.preferredDatePickerStyle = .wheels
        }

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Onayla",
            style: .plain,
            target: self,
            action: #selector(endDateSelectionComplete)
        )
        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil
        )

        toolbar.setItems([spaceButton, doneButton], animated: false)
        endDateTextField.inputAccessoryView = toolbar
        endDateTextField.inputView = endDatePicker
    }

    @objc private func endDateSelectionComplete() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        endDateTextField.text = formatter.string(from: endDatePicker.date)
        endEditing(true)

        updateApplyFilterButtonStatus()
        setupStartDatePicker(maximumDate: endDatePicker.date)
    }

    @IBAction func applyFilterButtonTapped(_: Any) {
        applyFilterButtonAction?(startDateTextField.text!, endDateTextField.text!)
    }

    @IBAction func clearFilterButtonTapped(_: Any) {
        clearFilterButtonAction?()
    }
}
