//
//  LoginViewModel.swift
//  DragonBall
//
//  Created by Daniel Cazorro Frías on 10/10/23.
//

import Foundation

class LoginViewModel: LoginViewControllerDelegate {
    
    // MARK: - Properties -
    var viewState: ((LoginViewState) -> Void)?
    
    // MARK: - Public functions -
    func onLoginPressed(email: String?, password: String?) {
        viewState?(.loading(true))
        
        guard isValid(email: email) else {
            viewState?(.loading(false))
            viewState?(.showErrorEmail("Indique un email válido"))
            return
        }
        
        guard isValid(password: password) else {
            viewState?(.loading(false))
            viewState?(.showErrorPassword("Indique un password válido"))
            return
        }
        
        doLoginWith(
            email: email ?? "",
            password: password ?? "")
    }
    
    private func isValid(email: String?) -> Bool {
        email?.isEmpty == false && email?.contains("@") ?? false
    }
    
    private func isValid(password: String?) -> Bool {
        password?.isEmpty == false && (password?.count ?? 0) >= 4
    }
    
    private func doLoginWith(email: String, password: String) {
        
    }
}
