//
//  HerosInteractor.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 8/11/23.
//

import Foundation
import Combine

protocol HerosInteractorProtocol: AnyObject {
    func getHeros(filter: String) -> AnyPublisher<[Heros], Error>
}

final class HerosInteractor: HerosInteractorProtocol {
    func getHeros(filter: String) -> AnyPublisher<[Heros], Error> {
        return networker.callServer(type: [Heros].self, request: baseNetwork.getSessionHero(filter: filter))
    }
    

    
    let networker: NetworkerProtocol // Genérico
    let baseNetwork: BaseNetwork
    
    init(network: NetworkerProtocol = Networker(), baseNetwork: BaseNetwork = BaseNetwork()){
        self.networker = network
        self.baseNetwork = baseNetwork
        
    }
}

final class HerosInteractorFake: HerosInteractorProtocol {
    func getHeros(filter: String) -> AnyPublisher<[Heros], Error> {
        return networker.callServer(type: [Heros].self, request: baseNetwork.getSessionHero(filter: filter))
    }
    

    
    let networker: NetworkerProtocol // Genérico
    let baseNetwork: BaseNetwork
    
    init(network: NetworkerProtocol = Networker(), baseNetwork: BaseNetwork = BaseNetwork()){
        self.networker = network
        self.baseNetwork = baseNetwork
        
    }
}
