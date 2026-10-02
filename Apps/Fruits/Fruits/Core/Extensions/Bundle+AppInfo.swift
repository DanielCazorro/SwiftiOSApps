//
//  Bundle+AppInfo.swift
//  Fruits
//
//  Created by Daniel Cazorro on 02/10/2026.
//

import Foundation

extension Bundle {
    var appVersion: String {
        object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }

    var minimumOSVersion: String {
        object(forInfoDictionaryKey: "MinimumOSVersion") as? String ?? ""
    }
}
