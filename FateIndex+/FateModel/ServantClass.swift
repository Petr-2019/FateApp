//
//  ServantClass.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/1.
//  Copyright © 2019 管君. All rights reserved.
//

// 英灵职阶
enum ServantClass {

    case saber
    case archer
    case lancer
    case rider
    case caster
    case assassin
    case berserker
    case shielder
    case ruler
    case avenger
    case moonCancer
    case alterego
    case foreigner

    func description() -> String {
        switch self {
        case .saber:
            return "Saber"
        case .archer:
            return "Archer"
        case .lancer:
            return "Lancer"
        case .rider:
            return "Rider"
        case .caster:
            return "Caster"
        case .assassin:
            return "Assassin"
        case .berserker:
            return "Berserker"
        case .shielder:
            return "Shielder"
        case .ruler:
            return "Ruler"
        case .avenger:
            return "Avenger"
        case .moonCancer:
            return "MoonCancer"
        case .alterego:
            return "Alterego"
        case .foreigner:
            return "Foreigner"
        }
    }

}
