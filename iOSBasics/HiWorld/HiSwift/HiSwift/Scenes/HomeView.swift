//
//  HomeView.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 2/3/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.verticalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            CompactDesign()
        } else {
            RegularDesign()
        }
    }
}

struct RegularDesign: View {
    let phoneNumber = "623472525"
    let message = "Hello! How are you?"
    
    func sendMessage() {
        let sms = "sms:\(phoneNumber)&body=\(message)"
        guard let encodedSMS = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedSMS) else { return }
        UIApplication.shared.open(url)
    }
    
    func sendCall() {
        guard let number = URL(string: "tel://\(phoneNumber)") else { return }
        UIApplication.shared.open(number)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, .red]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            HStack {
                Image(systemName: "laptopcomputer.and.iphone")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("María Rodriguez")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                    
                    Text("Street Nutrition")
                        .font(.title)
                        .italic()
                        .foregroundColor(.yellow)
                    
                    HStack(spacing: 20) {
                        Button(action: { sendCall() }) {
                            Image(systemName: "phone.fill")
                        }
                        .modifier(CustomButtonStyle(color: .blue))
                        
                        Button(action: { sendMessage() }) {
                            Image(systemName: "message.fill")
                        }
                        .modifier(CustomButtonStyle(color: .red))
                    }
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CompactDesign: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .blue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .padding()
                    .foregroundColor(.white)
                
                VStack(alignment: .center, spacing: 10) {
                    Text("María Rodriguez")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                    
                    Text("Street Nutrition")
                        .font(.title)
                        .italic()
                        .foregroundColor(.yellow)
                }
                .padding()
            }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CustomButtonStyle: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(color)
            .clipShape(Circle())
            .foregroundColor(.white)
            .font(.title)
            .shadow(radius: 5)
    }
}

#Preview {
    HomeView()
}
