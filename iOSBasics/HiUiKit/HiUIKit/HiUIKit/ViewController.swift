//
//  ViewController.swift
//  HiUIKit
//
//  Created by Daniel Cazorro Frías on 2/3/25.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Properties
    private let greetingMessage = "Hello, World!"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        titleLabel.text = greetingMessage
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
    }
    
    // MARK: - Methods
    private func updateTitleLabel(with text: String) {
        titleLabel.text = text
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendSegue",
           let destinationVC = segue.destination as? GreetingViewController {
            destinationVC.greetingMessage = greetingMessage
        }
    }

    // MARK: - IBActions
    @IBAction func showAlert(_ sender: UIButton) {
        updateTitleLabel(with: "Touched Alert")
        
        let alertController = UIAlertController(title: "Notice",
                                                message: "Congratulations!",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Accept", style: .default) { [weak self] _ in
            print("OK pressed")
            self?.updateTitleLabel(with: "Alert dismissed")
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true) {
            print("Alert presented")
        }
    }
    
    @IBAction func backtoHome(_ sender: UIStoryboardSegue) {
        print("Back to Home")
    }
}

