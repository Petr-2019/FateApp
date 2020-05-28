//
//  Bundle+Extension.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/5/28.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation
import UIKit

extension Bundle {
    public var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last {
            return UIImage(named: lastIcon)
        }
        return nil
    }
}
