//
//  SplashViewController.swift
//  MVVMPatrones
//
//  Created by Daniel Cazorro Frías on 3/10/23.
//

import UIKit


// MARK: - PROTOCOLO -

protocol SplashViewProtocol {
    
    func showLoading(_ show: Bool)
    func navigateToHome()
    
}

// MARK: - CLASE -

class SplashViewController: UIViewController {

    //MARK: - IBOutlets -
    
    @IBOutlet weak var activitiIndicator: UIActivityIndicatorView!
    
    var viewModel: SplashViewModelProtocol?
    
    // MARK: - Ciclo de Vida -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SplashViewModel()
        viewModel?.onViewsLoaded()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activitiIndicator.stopAnimating()
    }

}

// MARK: - EXTENSION -
extension SplashViewController: SplashViewProtocol {
    
    // Método cargar activity indicator
    func showLoading(_ show: Bool) {
        switch show {
        case true where !activitiIndicator.isAnimating:
            activitiIndicator.startAnimating()
        case false where activitiIndicator.isAnimating:
            activitiIndicator.stopAnimating()
        default: break
        }
    }
    
    // Método para navegar a la home
    func navigateToHome() {
        
        let nextVC = HomeTableViewController()
        navigationController?.setViewControllers([nextVC], animated: true)
        
    }
    
    
}
