//
//  ThirdViewController.swift
//  HelloWorld
//
//  Created by Daniel Cazorro Frías on 14/10/24.
//

import UIKit

class ThirdViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func didTapXiB(_ sender: Any) {
        let viewController = XiBViewController()
        navigationController?.show(viewController, sender: nil)
    }

    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        segue.destination.preferredContentSize = CGSize(width: 200, height:  200)
        
        if let presentationController = segue.destination.presentationController {
            presentationController.delegate = self
        }
    }
}

// MARK: - UIPopoverPresentationControllerDelegate
extension ThirdViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController,
                                   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        .none
    }
}
