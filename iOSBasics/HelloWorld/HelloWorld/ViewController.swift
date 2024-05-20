//
//  ViewController.swift
//  HelloWorld
//
//  Created by Daniel Cazorro Frías on 2/10/23.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    private var isBlueBackground = false
    
    // MARK: - IBOutlets
    @IBOutlet weak var helloWorldLabel: UILabel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        helloWorldLabel.text = "Hello iOS Developers! 👏🏻"
        helloWorldLabel.backgroundColor = .clear
    }

    // MARK: - IBActions
    @IBAction func didTapButton(_ sender: Any) {
        changeBackgroundColor()
    }
    
    // MARK: - Private Methods -
    private func changeBackgroundColor() {
        isBlueBackground.toggle()
        
        updateBacgroundColor()
        
        print("Button tapped. Background color is now \(isBlueBackground ? "blue" : "clear")")
    }
    
    private func updateBacgroundColor() {
        helloWorldLabel.backgroundColor = isBlueBackground ? .blue : .clear
    }
    
}
