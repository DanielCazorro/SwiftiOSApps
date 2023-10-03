//
//  ViewController.swift
//  HelloWorld
//
//  Created by Daniel Cazorro Frías on 2/10/23.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets -
    
    @IBOutlet weak var helloWorldLabel: UILabel!
    
    // MARK: - IBActions -
    
    @IBAction func didTapButton(_ sender: Any) {
        print("Hello World")
        helloWorldLabel.backgroundColor = .blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloWorldLabel.text = "Hello Keepcoding! 👏🏻"
        helloWorldLabel.backgroundColor = .clear
    }


}

