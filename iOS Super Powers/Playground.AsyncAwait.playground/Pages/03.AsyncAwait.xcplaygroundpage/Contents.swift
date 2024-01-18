/*
 
 Async Await
 
 */
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// Modelo de BootCamps
struct BootCamps: Codable {
    let id: UUID
    let name: String
}

final class testLoad{
    func loadBootCamps() async throws -> [BootCamps]{
        let url = URL(string: "https://dragonball.keepcoding.education/api/data/bootcamps")
        
        let (data, _) = try await URLSession.shared.data(from: url!)
        
        // 200, etc.
        
        return try JSONDecoder().decode([BootCamps].self, from: data)
        
    }
}

// Task
/*
 Que es Task? Provee de un contexto asincrono para ejecucion codigo concurrente.
 A Task se le puede indicar la prioridad:
 
Task(priority: .medium) . Hay 6 tipos de prioridades
  high
  medium
  low
  userInitiated
  utility
  background*/
Task(priority: .high){
    let obj = testLoad()
    let data = try await obj.loadBootCamps()
    
    data.forEach{ bootcamp in
        print("\(bootcamp.id) - \(bootcamp.name)")
        print("Async-Await")
        
    }
}
