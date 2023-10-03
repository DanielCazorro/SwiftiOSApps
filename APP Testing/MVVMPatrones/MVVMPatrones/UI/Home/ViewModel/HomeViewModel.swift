//
//  HomeViewModel.swift
//  MVVMPatrones
//
//  Created by Daniel Cazorro Frías on 3/10/23.
//

import Foundation


// MARK: - Protocolo -

protocol HomeViewModelProtocol {
    
    func onViewsLoaded()
    
}




// MARK: - Clase -

final class HomeViewModel {
    
    private weak var viewDelegate: HomeViewProtocol?
    
    init(viewDelegate: HomeViewProtocol? = nil) {
        self.viewDelegate = viewDelegate
    }
    
}



// MARK: - Extensión -

extension HomeViewModel: HomeViewModelProtocol {
    
    func onViewsLoaded() {
        <#code#>
    }
    
    
    
    
}
