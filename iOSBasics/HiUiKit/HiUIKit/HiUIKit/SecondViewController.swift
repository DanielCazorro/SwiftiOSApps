//
//  SecondViewController.swift
//  HiUIKit
//
//  Created by Daniel Cazorro Frías on 17/3/25.
//

import UIKit

class GreetingViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var messageLabel: UILabel!

    // MARK: - Properties
    var greetingMessage: String = ""

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        messageLabel.text = greetingMessage
        messageLabel.textColor = UIColor.label
        messageLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        messageLabel.textAlignment = .center
    }

    // MARK: - IBActions
    @IBAction func didTapBackButton(_ sender: UIButton) {
//        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
}
