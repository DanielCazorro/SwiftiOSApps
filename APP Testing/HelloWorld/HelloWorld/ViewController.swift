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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloWorldLabel.text = "Hello Keepcoding! 👏🏻"
        helloWorldLabel.backgroundColor = .clear
    }


}

