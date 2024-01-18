//
//  ViewController.swift
//  HelloWorld
//
//  Created by Daniel Cazorro Frías on 23/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var helloWorldLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helloWorldLabel.text = "Hello Hunters! 🔥"
        helloWorldLabel.backgroundColor = .clear
    }


}

