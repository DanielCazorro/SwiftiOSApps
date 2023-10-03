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
    
    
    private func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            // TODO: Notificar a la vista que navegue a la Home
        }
    }
    
}

// MARK: - EXTENSIÓN -

extension SplashViewModel: SplashViewModelProtocol {
    
    func onViewsLoaded() {
        loadData()
    }
    
}
