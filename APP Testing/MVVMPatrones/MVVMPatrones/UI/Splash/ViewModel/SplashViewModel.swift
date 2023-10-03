//
//  SplashViewModel.swift
//  MVVMPatrones
//
//  Created by Daniel Cazorro Frías on 3/10/23.
//

import Foundation

// MARK: - PROTOCOLO -

protocol SplashViewModelProtocol {
    func onViewsLoaded()
    
}


// MARK: - CLASE -

final class SplashViewModel {
    
    var viewDelegate: SplashViewProtocol?
    
    init(viewDelegate: SplashViewProtocol?) {
        self.viewDelegate = viewDelegate
    }
    
    private func loadData() {
        viewDelegate?.showLoading(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            self?.viewDelegate?.showLoading(false)
            self?.viewDelegate?.navigateToHome()
        }
    }
    
}

class pepito {
    private func loadData() {
        print("Hola Pepito")
    }
}

extension pepito: SplashViewModelProtocol {
    func onViewsLoaded() {
        loadData()
    }
    
    
}

// MARK: - EXTENSIÓN -

extension SplashViewModel: SplashViewModelProtocol {
    
    func onViewsLoaded() {
        loadData()
    }
    
}
