//
//  Gender.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/2.
//  Copyright © 2019 管君. All rights reserved.
//

import Foundation

enum Gender {
    case male
    case female
    case unknown

    func description() -> String {
        switch self {
        case .male: return "男性"
        case .female: return "女性"
        case .unknown: return "未知"
        }
    }
}
