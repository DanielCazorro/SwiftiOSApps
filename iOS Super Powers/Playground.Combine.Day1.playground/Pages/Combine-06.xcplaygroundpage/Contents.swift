//: [Previous](@previous)

import Foundation
import Combine
import UIKit

// Para que funcione URLSession aquí...
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


// Creamos un ViewModel

final class viewModelPhoto {
    
    var photo: UIImage?{
        didSet{
            print("Foto recibida OK")
            photo // Solo para depurar el playGround
        }
    }
    
    init(){
        
    }
    
    // Suscriptor
    var suscriber: AnyCancellable?
    
    // Función de descarga de una foto
    func DownloadImage(urlS: String) -> Void {
        let url = URL(string: urlS)!
        
        suscriber = URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap{
                guard let httpResponse = $0.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200  else{
                    throw URLError(.badServerResponse)
                }
                return $0.data // Devuelvo el dato de l respuesa... DATA
            }
            .map {
                UIImage(data: $0)
            }
            .receive(on: DispatchQueue.main) // Al hilo principal
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error =>  \(error)")
                case .finished:
                    print("finaliza OK")
                }
            }, receiveValue: {
                if let foto = $0 {
                    self.photo = foto // Foto
                }
            })
        
        
        
    }
}

// Testeamos!

let vm = viewModelPhoto()
vm.DownloadImage(urlS: "https://i.blogs.es/f7b0ed/steve-jobs/1366_2000.jpg")

//: [Next](@next)
