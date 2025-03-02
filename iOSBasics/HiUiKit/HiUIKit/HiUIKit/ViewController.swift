//
//  ViewController.swift
//  HiUIKit
//
//  Created by Daniel Cazorro Frías on 2/3/25.
//

import UIKit

class ViewController: UIViewController {

    // IBOutlet
    @IBOutlet weak var homeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func changeHomeLabelText(_ text: String) {
        homeLabel.text = text
    }

    // IBActions
    @IBAction func pressAlert(_ sender: UIButton) {
        changeHomeLabelText("Touched Alert")
        
        let alert = UIAlertController(title: "Alert Title", message: "Congratulations!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default) { [weak self] _ in
            print("OK pressed")
            self?.changeHomeLabelText("Alert dismissed")
        }
        alert.addAction(okAction)
        present(alert, animated: true) {
            print("Alert presented")
        }
    }
}

