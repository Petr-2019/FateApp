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
        if imageName == "狂化" {
            reducedName = "狂化"
        }
        else if imageName == "show_alone" {
            reducedName = "单独行动"
        }
        else if imageName == "surfing" {
            reducedName = "蓝放"
        }
        else if imageName == "veteran" {
            reducedName = "蓝放"
        }
        else if imageName == "回合充能" {
            reducedName = "回合充能"
        }
        else if imageName == "mixed_blood" {
            reducedName = "回合充能"
        }
        else if imageName == "scoundrel" {
            reducedName = "暴击威力提升"
        }
        else if imageName == "arutoria_reactor" {
            reducedName = "弱化耐性提升"
        }
        else if imageName == "空白效果" {
            reducedName = "空白效果"
        }
        else if imageName == "high_servant" {
            reducedName = "空白效果"
        }
        else if imageName == "beast_rightSkill" {
            reducedName = "暴击威力提升"
        }
        else if imageName == "rationale_eater" {
            reducedName = "加防"
        }
        else if imageName == "nega_saver" {
            reducedName = "特攻"
        }
        else if imageName == "root_consist" {
            reducedName = "特攻"
        }
        else if imageName == "civilization_invade" {
            reducedName = "暴击威力提升"
        }
        else if imageName == "rage_breathe" {
            reducedName = "beast_become"
        }
        else if imageName == "elf_contract" {
            reducedName = "弱化耐性提升"
        }
        else if imageName == "homunclus" {
            reducedName = "蓝放"
        }
        else if imageName == "ground_eater" {
            reducedName = "弱化耐性提升"
        }
        else if imageName == "aggressive_become" {
            reducedName = "beast_become"
        }
        else if imageName == "hotel_build" {
            reducedName = "蓝放"
        }
        else if imageName == "ventriloquy" {
            reducedName = "弱化无效"
        }
        else if imageName == "cupid_core" {
            reducedName = "神性"
        }
        else if imageName == "symbol_of_anger" {
            reducedName = "红放"
        }
        else if imageName == "body_of_king" {
            reducedName = "NP获得量提升"
        }
        else if imageName == "overhaul" {
            reducedName = "弱化耐性提升"
        }
        else if imageName == "fortress_build" {
            reducedName = "阵地作成"
        }
        else {
            reducedName = imageName
        }

        // 狂化, beast_become

        return UIImage(named: reducedName)
    }
}
