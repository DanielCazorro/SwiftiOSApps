//
//  CaclViewController.swift
//  HiUIKit
//
//  Created by Daniel Cazorro Frías on 6/3/25.
//

import UIKit

class DiscountCalculatorViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var percentageTextField: UITextField!
    
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor.systemGroupedBackground

        configureLabel(resultLabel)
        configureLabel(discountLabel)
        
        configureTextField(amountTextField, placeholder: "Enter amount")
        configureTextField(percentageTextField, placeholder: "Enter discount %")

        configureButton(calculateButton, title: "Calculate", color: .systemBlue)
        configureButton(clearButton, title: "Clear", color: .systemRed)
    }

    private func configureLabel(_ label: UILabel) {
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
    }

    private func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .secondarySystemBackground
        textField.textColor = .label
        textField.placeholder = placeholder
        textField.keyboardType = .decimalPad
    }

    private func configureButton(_ button: UIButton, title: String, color: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }

    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func didTapCalculateButton(_ sender: UIButton) {
        guard let amountText = amountTextField.text, let discountText = percentageTextField.text,
              let amount = Float(amountText), let discount = Float(discountText) else {
            showErrorAlert()
            return
        }

        let discountValue = amount * discount / 100
        let finalPrice = amount - discountValue

        resultLabel.text = String(format: "%.2f €", finalPrice)
        discountLabel.text = String(format: "%.2f €", discountValue)
        view.endEditing(true)
    }
    
    @IBAction func didTapClearButton(_ sender: UIButton) {
        amountTextField.text = ""
        percentageTextField.text = ""
        resultLabel.text = "0.00 €"
        discountLabel.text = "0.00 €"
    }

    // MARK: - Helper Methods
    private func showErrorAlert() {
        let alertController = UIAlertController(title: "Input Error",
                                                message: "Please enter valid numbers.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
