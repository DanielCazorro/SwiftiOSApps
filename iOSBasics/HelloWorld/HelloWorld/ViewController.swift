//
//  ViewController.swift
//  HelloWorld
//
//  Created by Daniel Cazorro Frías on 2/10/23.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    private var isBlueBackground = true
    
    // MARK: - IBOutlets
    @IBOutlet weak var helloWorldLabel: UILabel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions
    @IBAction func didTapButton(_ sender: Any) {
        changeBackgroundColor()
    }
    
    // MARK: - Private Methods -
    private func changeBackgroundColor() {
        isBlueBackground.toggle()
        
        updateBacgroundColor()
        updateHelloWorldLabel()
        
        print("Button tapped. Background color is now \(isBlueBackground ? "blue" : "clear")")
    }
    
    private func updateHelloWorldLabel() {
        helloWorldLabel.text = isBlueBackground ? "Hello World 🖖🏻" : "Hello iOS Developers! 👏🏻"
    }
        
    private func updateBacgroundColor() {
        helloWorldLabel.backgroundColor = isBlueBackground ? .blue : .clear
    }
}