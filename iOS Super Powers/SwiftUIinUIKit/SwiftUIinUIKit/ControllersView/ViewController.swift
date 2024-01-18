//
//  ViewController.swift
//  SwiftUIinUIKit
//
//  Created by Daniel Cazorro Frías on 8/11/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func openSwiftUIView(_ sender: Any) {
        // Abrimos vista de SwiftUI
        let view = UIHostingController(rootView: SwiftUITestView())
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    @IBAction func openTableViewController(_ sender: Any) {
        
        let vc = TableViewControllerTest()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

