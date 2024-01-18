/*
 
 Closures
 
 */
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// Modelo de BootCamps
struct BootCamps: Codable {
    let id: UUID
    let name: String
}

// Definimos los typeAlias
typealias successClosure = ([BootCamps])->Void
typealias errorClosure = (() -> Void)?

// Extensión de URLResponse
extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}


final class testLoad {
    func loadBootCamps(onSuccess: @escaping successClosure, onError: errorClosure) -> Void{
        let url = URL(string: "https://dragonball.keepcoding.education/api/data/bootcamps")
        var request : URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            
            // Aquí ha terminado la llamada
            if error != nil {
                onError!() // OJO!! Desempaquetar aquí...
                return
            }
            
            // Evaluar respuesta
            if (response?.getStatusCode() == 200){
                do{
                    if let datos = data {
                        // Decode
                        let model = try JSONDecoder().decode([BootCamps].self, from: datos)
                        
                        // Enviamos
                        onSuccess(model)
                        
                        
                    } else {
                        // No vienen datos
                        onError!
                    }
                    
                } catch {
                    onError!
                }
                
                
            } else {
                // Error
                onError!()
            }
        }
        
        task.resume()
    }
}



// La llamada a la función de la clase...

let obj = testLoad()

obj.loadBootCamps { data in
    // Success
    DispatchQueue.main.async{
        print("Cargados los BootCamps")
        data.forEach{ bootcamp in
            print("\(bootcamp.id) - \(bootcamp.name)")
            
        }
    }
    
    
} onError: {
    // Error
    DispatchQueue.main.async{
        print("Error")
    }
    
}


