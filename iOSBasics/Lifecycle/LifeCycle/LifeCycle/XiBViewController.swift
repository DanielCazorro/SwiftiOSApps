//
//  XiBViewController.swift
//  LifeCycle
//
//  Created by Daniel Cazorro Frías on 22/10/24.
//

import UIKit

class XiBViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Model
    private let text: String
    
    // MARK: - Initializers
    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
        print("🙌🏼 XiBViewController init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = text
    }
}
