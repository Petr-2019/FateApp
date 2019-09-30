//
//  ThemeManager.swift
//  FateIndex+
//
//  Created by Peter Guan on 2019/7/31.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

public protocol Themeable {
    func themeDidChange()
    
}

extension Themeable {
    
    /// Trigger `themeDidChange()`.
    ///
    /// - Parameters:
    ///   - views: Views visible by user, will be snapshoted if animated.
    ///   - animated: Animate or not
    func updateAppearance(with views: [UIView], animated: Bool) {
        
    }
    
}

public enum Theme: Int, CustomDebugStringConvertible {
    case light = 0
    case dark
    
    public var debugDescription: String {
        switch self {
        case .light:
            return "light"
        case .dark:
            return "dark"
        }
    }
}

public final class ThemeManager {
    
    public static let themeChangedNotification = Notification.Name("ThemeChanged")
    
    public internal(set) var current: Theme {
        didSet {
            if oldValue != current {
                SettingsManager.shared.setCurrentTheme(rawValue: current.rawValue)
                // log it's changed
                NotificationCenter.default.post(name: ThemeManager.themeChangedNotification, object: self)
            }
        }
    }
    
    private init() {
        current = Theme(rawValue: SettingsManager.shared.currentTheme()) ?? .light
    }
    
    public static func setup() {
        // do some swizzle here
    }
    
    public func toggle() {
        switch self.current {
        case .light:
            current = .dark
        case .dark:
            current = .light
        }
    }
}
