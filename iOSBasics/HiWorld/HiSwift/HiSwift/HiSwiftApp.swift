//
//  HiSwiftApp.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 24/2/25.
//

import SwiftUI

@main
struct HiSwiftApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    init() {
        start()
    }
    
    var body: some Scene {
        WindowGroup {
            TabViewMain()
        }.onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
            case .active:
                print("The app is active")
            case .background:
                print("The app is in background")
            case .inactive:
                print("The app is inactive")
            @unknown default:
                print("The app is in unknown state")
            }
        }
    }
    
    
    func start() {
#if os(iOS)
        print("iOS")
#elseif os(macOS)
        print("macOS")
#elseif os(tvOS)
        print("tvOS")
#elseif os(watchOS)
        print("watchOS")
#endif
    }
}
