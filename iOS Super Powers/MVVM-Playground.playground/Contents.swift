/*
 MVVM iOS13-16
 
 MVVM con SwiftUI
 */

import SwiftUI
import Combine
import PlaygroundSupport // Solo para que funcione SwfitUI aquí

// -------- Models --------

struct Person: Codable {
    let id: UUID
    let name: String
    let apells: String
    let nif: String
}

enum Estados {
    case none, loading, loaded, error
}


// ---------- ViewModel ---------

final class ViewModelPerson: ObservableObject {
    
    @Published var data: Person? // Modelo de la persona
    @Published var estado: Estados = .none // Estado de la llamada de red (simulada)
    
    init(){
        loadPerson()
    }
    
    // Carga el empleado simulando llamada de red
    
    func loadPerson(){
        estado = .loading // Cambia el estado
        
        // Simulamos una llamada de red, que esperamos 2 segundos
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            self.data = Person(id: UUID(), name: "Manuel", apells: "Bustos Llanos", nif: "12345678H")
            self.estado = .loaded
        }
    }
}


// ---------- View SwiftUI ----------

struct ContentView : View {
    
    @StateObject private var viewModel = ViewModelPerson()
    
    var body: some View{
        
        switch viewModel.estado {
        case .none:
            Text("Estado none")
            
        case .loading:
            Text("Cargando datos")
            
        case .error:
            Text("Se ha producido un error")
            
        case .loaded:
            VStack{
                if let data = viewModel.data {
                    // Imagen del empleado
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    // Nombre
                    //let fullName = data.name + " " + data.apells
                    //Text(fullName)
                    Text("\(data.name) \(data.apells) ")
                    
                } else {
                    Text("No hay datos")
                }
            }
            .padding()
            .onReceive(self.viewModel.$data, perform: { _ in
                // Se ejecuta antes de repintar la UI
                print("Cambia el dato...\(self.viewModel.data?.name)")
            })
            .onReceive(self.viewModel.$estado, perform: { _ in
                // Se ejecuta antes de repintar la UI
                print("Cambia el estado")
            })
        }
    }
}


// Ejecuta la salida de la view en el Playground
PlaygroundPage.current.setLiveView(ContentView().frame(width:200, height: 200))
