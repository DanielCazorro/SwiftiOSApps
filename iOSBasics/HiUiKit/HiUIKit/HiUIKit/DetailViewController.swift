//
//  DetailViewController.swift
//  HiUIKit
//
//  Created by Daniel Cazorro Frías on 25/3/25.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var listData: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = listData?.name
        emailLabel.text = listData?.email
    }
}
