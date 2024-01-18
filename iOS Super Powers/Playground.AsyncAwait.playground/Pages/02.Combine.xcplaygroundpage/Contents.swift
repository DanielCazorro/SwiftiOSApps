/*
 
 Combine
 
 */
import Foundation
import Combine
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// Modelo de BootCamps
struct BootCamps: Codable {
    let id: UUID
    let name: String
}


// Extensión de URLResponse
extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}


// COMBINE
final class testLoad {
    var bootCamps: [BootCamps] = Array<BootCamps>()
    
    var suscriptors = Set<AnyCancellable>() // Suscriptor
    
    func loadBootCamps(){
        let url = URL(string: "https://dragonball.keepcoding.education/api/data/bootcamps")
        var request : URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        // Aquí empieza combine
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap{
                if $0.response.getStatusCode() == 200 {
                    return $0.data
                    
                } else {
                    throw URLError(.badServerResponse)
                    
                }
            }
            .decode(type: [BootCamps].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            //.replaceError(with: Array<BootCamps>())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finaliza OK")
                case .failure(let errorString):
                    print("Error red \(errorString)")
                }
            } receiveValue: { data in
                // Llega el dato
                self.bootCamps = data
                self.printData() // Imprimir en consla
            }
            .store(in: &suscriptors)
    }
    
    func printData(){
        bootCamps.forEach{ bootcamp in
            print("\(bootcamp.id) - \(bootcamp.name)")
            
        }
    }
}


// Realizao la llamada

let obj = testLoad()
obj.loadBootCamps()
