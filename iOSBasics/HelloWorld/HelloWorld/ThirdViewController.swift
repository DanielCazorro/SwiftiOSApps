//
//  ThirdViewController.swift
//  HelloWorld
//
//  Created by Daniel Cazorro Frías on 14/10/24.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        segue.destination.preferredContentSize = CGSize(width: 300, height:  300)
        
        if let presentationController = segue.destination.presentationController {
            presentationController.delegate = self
        }
    }
}

extension ThirdViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController,
                                   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        .none
    }
}