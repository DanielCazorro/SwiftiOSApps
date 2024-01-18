//
//  EmployeeDetailView.swift
//  kcMultiplataforma2023
//
//  Created by Daniel Cazorro Frías on 2/11/23.
//

import SwiftUI

struct EmployeeDetailView: View {
    
    let employee: Empleados
    
    var body: some View {
        
        ScrollView{
            VStack{
                // Imagen
                
#if os(watchOS)
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                
                
#else
                
                
                Image(systemName: "person")
                    .resizable()
                    .frame(minWidth: 100, idealWidth: 200, maxWidth: .infinity, minHeight: 100, idealHeight: 200, maxHeight: 300)
                    .foregroundColor(.white)
                
                
#endif
                
                // Label
                Text("\(employee.nombre)")
                    .padding()
                Text("\(employee.apell1)")
                    .padding()
                
                if let apell2 = employee.apell2{
                    Text("\(apell2)")
                        .padding()
                }
                
                HStack{
                    Spacer()
                    Text("\(employee.edad)")
                        .padding()
                }
                Spacer()
                
            }
            .background(.gray)
        }
    }
}

#Preview {
    EmployeeDetailView(employee: Empleados(id: "100", nombre: "jose luis", apell1: "bustos", apell2: "Esteban", idPhoto: "091", edad: 22))
}
