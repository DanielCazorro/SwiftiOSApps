//
//  ChartsView.swift
//  KcSwfitUIComponents
//
//  Created by Daniel Cazorro Frías on 31/10/23.
//

import SwiftUI
import Charts

struct Values: Identifiable {
    let id = UUID()
    
    let title: String
    let value: Int
    let color: Color
}


struct ChartsView: View {
    
    var vals : [Values] = [
        Values(title: "Goku", value: 100, color: .red),
        Values(title: "Krillin", value: 50, color: .blue),
        Values(title: "Veggeta", value: 90, color: .orange),
        Values(title: "Freezer", value: 95, color: .purple)
        
    ]
    
    var body: some View {
        VStack{
            Text("Unidades de Combate")
            
            Chart{
                ForEach(vals) { value in
                    BarMark(x: .value("", value.title), y: .value("", value.value))
                        .foregroundStyle(value.color)
                }
            }
            
            
            Chart{
                ForEach(vals) { value in
                    PointMark(x: .value("", value.title), y: .value("", value.value))
                        .foregroundStyle(value.color)
                }
            }
            
            
            Chart{
                ForEach(vals) { value in
                    RectangleMark(x: .value("", value.title), y: .value("", value.value))
                        .foregroundStyle(value.color)
                }
            }
            
            
            Chart{
                ForEach(vals) { value in
                    AreaMark(x: .value("", value.title), y: .value("", value.value))
                        .foregroundStyle(value.color)
                }
            }
            
        }
    }
}

#Preview {
    ChartsView()
}
