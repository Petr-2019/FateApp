//
//  SettingsManager.swift
//  FateIndex+
//
//  Created by Peter Guan on 2019/7/31.
//  Copyright © 2019 管君. All rights reserved.
//

import Foundation

public class SettingsManager {
    
    private struct Constants {
        static let currentTheme = "current-theme"
    }
    
    public static let shared = SettingsManager()
    
    private let userDefaults = UserDefaults.standard
    
    public func currentTheme() -> Int {
        return userDefaults.integer(forKey: Constants.currentTheme)
    }
    
    public func setCurrentTheme(rawValue: Int) {
        userDefaults.set(rawValue, forKey: Constants.currentTheme)
    }
}
