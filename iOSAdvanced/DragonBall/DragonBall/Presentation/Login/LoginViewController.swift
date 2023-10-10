//
//  LoginViewController.swift
//  DragonBall
//
//  Created by Daniel Cazorro Frías on 10/10/23.
//

import UIKit

// MARK: - View Protocol -
protocol LoginViewControllerDelegate {
    var viewState: ((LoginViewState) -> Void)? { get set }
    func onLoginPressed(email: String?, password: String?)
}

// MARK: - View State -
enum LoginViewState {
    case loading(_ isLoading: Bool)
    case showErrorEmail(_ error: String?)
    case showErrorPassword(_ error: String?)
    case navigateToNext
}

class LoginViewController: UIViewController {

    // MARK: - IBOutlet -
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailFieldError: UILabel!
    @IBOutlet weak var passwordFieldError: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    // MARK: - IBAction -
    @IBAction func onLoginPressed() {
        // TODO: Obtener el email y password introducidos por el usuario y enviarlos al servicio del API de Login (VIEWMODEL)
        
        viewModel?.onLoginPressed(
            email: emailField.text,
            password: passwordField.text)
        
    }
    
    // MARK: - Public Properties -
    var viewModel: LoginViewControllerDelegate?
    
    private enum FieldType: Int {
        case email = 0
        case password
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setObservers()
    }
    
    private func initViews() {
        emailField.delegate = self
        emailField.tag = FieldType.email.rawValue
        passwordField.delegate = self
        passwordField.tag = FieldType.password.rawValue
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(dismissKeyboard)
            )
        )
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setObservers() {
        viewModel?.viewState = { state in
            switch state {
            case .loading(let isLoading):
                self.loadingView.isHidden = !isLoading
                
            case .showErrorEmail(let error):
                self.emailFieldError.text = error
                self.emailFieldError.isHidden = (error == nil || error?.isEmpty == true)
                
            case .showErrorPassword(let error):
                self.passwordFieldError.text = error
                self.passwordFieldError.isHidden = (error == nil || error?.isEmpty == true)
                
            case .navigateToNext:
                self.loadingView.isHidden = true
                // TODO: Navegar a la siguiente vista
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch FieldType(rawValue: textField.tag) {
        case .email:
            emailFieldError.isHidden = true
            
        case .password:
            passwordFieldError.isHidden = true
            
        default: break
            
        }
        /*
        if emailField == textField {
            emailFieldError.isHidden = true
        } else if passwordField == textField {
            passwordFieldError.isHidden = true
        }
         */
    }
}
