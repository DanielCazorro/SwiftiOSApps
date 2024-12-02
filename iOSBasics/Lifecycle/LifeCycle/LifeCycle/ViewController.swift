//
//  ViewController.swift
//  LifeCycle
//
//  Created by Daniel Cazorro Frías on 22/10/24.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("✅ ViewController init")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super .loadView()
        print("✅ ViewController loadView")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("✅ ViewController viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("✅ ViewController viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("✅ ViewController viewDidAppear")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("✅ ViewController viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("✅ ViewController viewDidDisappear")
    }
    
    deinit {
        print("❌ ViewController deinit")
    }

    // MARK: - Actions
    @IBAction func didTapButton(_ sender: Any) {
        let viewController = XiBViewController(text: "Hello 👋🏼")
        let secondViewControlle = XiBViewController(text: "Second")
//        navigationController?.show(viewController, sender: nil)
        navigationController?.setViewControllers([viewController, secondViewControlle], animated: true)
    }
}

