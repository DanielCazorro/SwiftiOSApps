//
//  RootViewModel.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 6/11/23.
//

import Foundation
import Combine

public let CONST_TOKEN_ID = "TokenJWTAppiOSBoot17"

final class RootViewModel: ObservableObject {
    @Published var status = Status.none // Estado
    @Published var isLogged: Bool = false // Indica si el usuario está logueado
    
    @Published var bootcamps: [BootCamp]? // Bootcam
    
    // Token del login
    /*
    @Published var tokenJWT: String = "" {
        didSet {
            print("Llega login: \(tokenJWT)")
            // Guardar en el KeyChain
            saveKC(key: CONST_TOKEN_ID, value: tokenJWT)
            
            if tokenJWT.count > 0 {
                isLogged = true
            } else {
                isLogged = false
            }
            
        }
    }
    */
    
    @kcPersistenceKeychain(key: CONST_TOKEN_ID)
    var tokenJWT {
        didSet {
            print("token login \(tokenJWT)")
        }
    }
    
    // Combine
    var suscriptors = Set<AnyCancellable>()
    
    // Inicializador
    init(testing: Bool = false) {
        self.LoggedUserControl() // Control de si el usuario está ya logueado
        
        // Cargamos los bootcamps si no estamos en modo testing o diseño
        if(!testing){
            self.loadBootcamps()
        } else {
            loadBootcampsTesting() // Design Mode
        }
    }
    
    // Cierre de sesión
    func CloseSession(){
        tokenJWT = ""
        status = .none
    }
    
    // Control de usuario conectado
    func LoggedUserControl() {
        /*
        let tokenOptional = loadKC(key: CONST_TOKEN_ID) // Leemos el token del KeyChain
        
        if let token = tokenOptional {
            tokenJWT = token // Asigno el token guardado
            status = .loaded
        }
        */
        if tokenJWT != "" {
            status = .loaded
        }
    }
    
    // Login al servidor
    func login(user:String, password: String) {
        
        status = .loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionLogin(user: user, password: password))
            .tryMap{
                // Evaluamos si es 200, sino lo es: Exception. Si es 200, devolvemos el JSON, que es el data
                guard let response = $0.response as?  HTTPURLResponse,
                      response.statusCode == 200 else {
                    //Error
                    throw URLError(.badServerResponse)
                }
                
                // Todo OK. Convierto el Data -> Cadena usando codificación utf8
                return String(decoding: $0.data, as: UTF8.self)
            }
            .receive(on: DispatchQueue.main) // Hilo principal
            .sink { completion in
                // Evaluamos la respuesta
                switch completion {
                case .failure:
                    self.status = .error(error: "Usuario y/o clave incorrecta") // Login Error
                case .finished:
                    self.status = .loaded // Login OK
                }
                
            } receiveValue: { token in
                self.tokenJWT = token
            }
            .store(in: &suscriptors)
        
    }
    
    func loadBootcamps(){
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionBootcamps())
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return $0.data
            }
            .decode(type: [BootCamp].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure:
                    self.status = .error(error: "Error buscando bootcamps")
                case .finished:
                    self.status = .loaded // Success
                }
            } receiveValue: { data in
                self.bootcamps = data
            }
            .store(in: &suscriptors)

    }
    
    // Diseño UI
    func loadBootcampsTesting(){
        let b1 = BootCamp(id: "01", name: "boot Mobile 1")
        let b2 = BootCamp(id: "02", name: "boot Mobile 2")
        let b3 = BootCamp(id: "03", name: "boot Mobile 3")
        let b4 = BootCamp(id: "04", name: "boot Mobile 4")
        
        // Asignarlos al modelo
        self.bootcamps = [b1, b2, b3, b4]
    }
    
}
