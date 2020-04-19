//
//  MasterEquipment.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/17.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation

struct MasterEquipment: Codable {
    struct MasterEquipmentSkill: Codable, Equatable {
        static func == (lhs: MasterEquipment.MasterEquipmentSkill, rhs: MasterEquipment.MasterEquipmentSkill) -> Bool {
            return lhs.skillName == rhs.skillName
        }

        struct LVEffects: Codable {
            let effectDesc: String
            let effects: [String]
        }

        let avatar: String
        let skillName: String
        let countDown: String
        let stableEffects: [String]
        let lvEffects: [LVEffects]
    }

    let id: String
    let name: String
    let desc: String
    let access: [String]
    let skills: [MasterEquipmentSkill]
}
