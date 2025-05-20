//
//  AppConfig.swift
//  School
//
//  Created by Mahmoud on 10/05/2025.
//

import Foundation
import CoreLocation

class AppConfiguration {
    static let shared = AppConfiguration()
    private init() { }
    
    var language: String {
        get {
            return UserDefaults.standard.load(object: String.self, fromKey: "AppLanguage") ?? "ar"
        }
        set {
            UserDefaults.standard.save(customObject: newValue, inKey: "AppLanguage")
        }
    }
}

