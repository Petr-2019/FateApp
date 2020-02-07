//
//  UIImage+Extension.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/1/25.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class UIImageUtility {

    static func classSkillImage(named imageName: String) -> UIImage? {
        let reducedName: String
        if imageName == "rage_become" {
            reducedName = "beast_become"
        }
        else if imageName == "show_alone" {
            reducedName = "acting_alone"
        }
        else if imageName == "surfing" {
            reducedName = "arts_up"
        }
        else if imageName == "veteran" {
            reducedName = "arts_up"
        }
        else if imageName == "magic_infinite" {
            reducedName = "np_gain_each_turn"
        }
        else if imageName == "mixed_blood" {
            reducedName = "np_gain_each_turn"
        }
        else if imageName == "scoundrel" {
            reducedName = "critical_up"
        }
        else if imageName == "arutoria_reactor" {
            reducedName = "weaken_stand_up"
        }
        else if imageName == "double_class" {
            reducedName = "no_effect_skill"
        }
        else if imageName == "high_servant" {
            reducedName = "no_effect_skill"
        }
        else if imageName == "beast_rightSkill" {
            reducedName = "critical_up"
        }
        else if imageName == "rationale_eater" {
            reducedName = "def_up"
        }
        else if imageName == "nega_saver" {
            reducedName = "special_attack_up"
        }
        else if imageName == "root_consist" {
            reducedName = "special_attack_up"
        }
        else if imageName == "civilization_invade" {
            reducedName = "critical_up"
        }
        else if imageName == "rage_breathe" {
            reducedName = "beast_become"
        }
        else if imageName == "elf_contract" {
            reducedName = "weaken_stand_up"
        }
        else if imageName == "homunclus" {
            reducedName = "arts_up"
        }
        else if imageName == "ground_eater" {
            reducedName = "weaken_stand_up"
        }
        else if imageName == "aggressive_become" {
            reducedName = "beast_become"
        }
        else if imageName == "hotel_build" {
            reducedName = "arts_up"
        }
        else if imageName == "ventriloquy" {
            reducedName = "weaken_no_affect"
        }
        else if imageName == "cupid_core" {
            reducedName = "divinity"
        }
        else if imageName == "symbol_of_anger" {
            reducedName = "buster_up"
        }
        else if imageName == "body_of_king" {
            reducedName = "np_gain_up"
        }
        else if imageName == "overhaul" {
            reducedName = "weaken_stand_up"
        }
        else if imageName == "fortress_build" {
            reducedName = "field_build"
        }
        else {
            reducedName = imageName
        }

        // rage_become, beast_become

        return UIImage(named: reducedName)
    }
}
