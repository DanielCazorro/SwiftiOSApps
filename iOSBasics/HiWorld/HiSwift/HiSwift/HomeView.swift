//
//  HomeView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 2/3/25.
//

import SwiftUI

struct HomeView: View {
    // Valores de entorno o EnvironmentValues
    @Environment(\.verticalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            compactDesign()
        } else {
            regularDesing()
        }
    }
}

struct regularDesing: View {
    let phoneNumber = "623472525"
    let message = "Hello! How are you?"
    
    func sendMessage() {
        let sms = "sms:\(phoneNumber)&body=\(message)"
        guard let stringSMS = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        UIApplication.shared.open((URL.init(string: stringSMS) ?? URL(string: "https://www.google.com")) ?? .applicationDirectory, options: [:], completionHandler: nil)
    }
    
    func sendCall() {
        guard let number = URL(string: "tel://\(phoneNumber)") else { return }
        UIApplication.shared.open(number)
    }
    
    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            HStack {
                Image(systemName: "laptopcomputer.and.iphone")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130, alignment: .center)
                    .padding()
                VStack(alignment: .leading, spacing: 10) {
                    Text("María Rodriguez")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .bold()
                    Text("Street Nutrition")
                        .foregroundStyle(.green)
                        .font(.title).italic()
                    HStack {
                        Button(action:{
                            sendCall()
                        }){
                            Image(systemName: "phone.fill")
                                .modifier(HiSwift.buttonStyle(color: .blue))
                        }
                        Button(action:{
                            sendMessage()
                        }){
                            Image(systemName: "message.fill")
                                .modifier(HiSwift.buttonStyle(color: .red))
                        }
                    }
                }
            }
        }
        .navigationTitle("HomeView")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTransition(.automatic)
    }
}

struct buttonStyle: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(color)
            .clipShape(Circle())
            .foregroundStyle(.white)
            .font(.title)    }
}

struct compactDesign: View {
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            VStack {
                Image(systemName: "arrow.up.circle")
                    .resizable()
                    .frame(width: 130, height: 130, alignment: .center)
                    .padding()
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 10) {
                    Text("María Rodriguez")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .bold()
                    Text("Street Nutrition")
                        .foregroundStyle(.green)
                        .font(.title).italic()
                }
            }
        }
        .navigationTitle("HomeView")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTransition(.automatic)
    }
}

#Preview {
    HomeView()
}
