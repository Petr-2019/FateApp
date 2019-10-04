//
//  CardType.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/3.
//  Copyright © 2019 管君. All rights reserved.
//

enum CardType {
    case arts
    case buster
    case quick

    func description() -> String {
        switch self {
        case .arts:
            return "Arts"
        case .buster:
            return "Buster"
        case .quick:
            return "Quick"
        }
    }

    func imgURL() -> String {
        switch self {
        case .arts:
            return "Arts"
        case .buster:
            return "Buster"
        case .quick:
            return "Quick"
        }
    }
}
