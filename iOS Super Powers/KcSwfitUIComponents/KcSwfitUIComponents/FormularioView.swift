//
//  FormularioView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI

struct FormularioView: View {
    @State var name:String = ""
    @State var apell1: String = ""
    @State var apell2: String = ""
    @State var hasChildren: Bool = false
    private var categories = ["Programador","Analista","Full Stack"]
    @State var selectedCategory = "Analista"
    
    var body: some View {
        NavigationStack{
            Form() {
                
                Section {
                    // Controles del formulario
                    TextField("Nombre", text: $name)
                        .autocorrectionDisabled()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    TextField("Apellido 1", text: $apell1)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    
                    TextField("Apelido 2", text: $apell2)
                        .autocorrectionDisabled()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    
                } header: {
                    // Nombre de la Sección
                    Text("Datos del empleado")
                }
                
                
                Section {
                    Toggle(isOn: $hasChildren, label: {
                        Text("Tienes hijos")
                    })
 
                } header: {
                    Text("Familia")
                }
                
                
                
                // Lista de categorías
                
                Section {
                    Picker(selection: $selectedCategory) {
                        // Lista de datos
                        ForEach(categories, id:\.self) {
                            Text($0)
                        }
                        
                    } label: {
                        Text("Categoría del RH")
                    }
                    .pickerStyle(.menu)
                    
                    
                    
                } header: {
                    Text("Datos Laborales")
                }
                
                
                Section {
                    Button(action: {
                        // Validar función del VM
                    }, label: {
                        HStack {
                        Spacer()
                        Text("Validar datos")
                        Spacer()
                    }
                           })
                    .foregroundColor(.white)
                }
                .listRowBackground(Color.orange)
            }
        }
        
    }
}

#Preview {
    FormularioView()
}
