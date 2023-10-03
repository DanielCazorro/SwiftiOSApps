//
//  SplashViewController.swift
//  MVCPatrones
//
//  Created by Daniel Cazorro Frías on 2/10/23.
//

import UIKit

class SplashViewController: UIViewController {

    // MARK: - OUTLETS -
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - CICLO DE VIDA -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // Cuando vaya aparecer
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(!activityIndicator.isAnimating) {
            activityIndicator.startAnimating()
        }
    }
    
    // Cuando vaya desaparecer
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityIndicator.stopAnimating()
    }
    
    // Método Simular carga de Datos
    private func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            let nextVC = HomeTableViewController()
            self.navigationController?.setViewControllers([nextVC], animated: true)

        }
    }
}
