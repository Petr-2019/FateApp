//
//  ServantManager.swift
//  FateIndex+
//
//  Created by Peter Guan on 2019/9/29.
//  Copyright © 2019 管君. All rights reserved.
//

import Foundation

class ServantManager {

    static let shared = ServantManager()

    func allServants() -> [Servant] {
        let servants = [
            Servant(id: 1, name: "玛修・基列莱特", classType: .shielder, gender: .female, maxATK: 8730, maxHP: 12877, giftFromEvent: true, painter: "", cardSequence: [.quick, .arts, .arts, .buster, .buster]),

            Servant(id: 2, name: "阿尔托莉雅・潘德拉贡", classType: .saber, gender: .female, maxATK: 11221, maxHP: 15150, giftFromEvent: false, painter: "武内崇", cardSequence: [.quick, .arts, .arts, .buster, .buster]),

            Servant(id: 3, name: "阿尔托莉雅・潘德拉贡(Alter)", classType: .saber, gender: .female, maxATK: 10248, maxHP: 11589, giftFromEvent: false, painter: "武内崇", cardSequence: [.quick, .arts, .arts, .buster, .buster]),

            Servant(id: 4, name: "阿尔托莉雅・潘德拉贡(Lily)", classType: .saber, gender: .female, maxATK: 7726, maxHP: 10623, giftFromEvent: true, painter: "武内崇", cardSequence: [.quick, .arts, .arts, .buster, .buster]),

            Servant(id: 5, name: "尼禄・克劳狄乌斯", classType: .saber, gender: .female, maxATK: 9449, maxHP: 11753, giftFromEvent: false, painter: "WADA ARUKO", cardSequence: [.quick, .arts, .arts, .buster, .buster]),

            Servant(id: 12, name: "吉尔伽美什", classType: .archer, gender: .male, maxATK: 12280, maxHP: 13097, giftFromEvent: false, painter: "武内崇", cardSequence: [.quick, .arts, .arts, .buster, .buster]),

            Servant(id: 23, name: "美杜莎", classType: .rider, gender: .female, maxATK: 7200, maxHP: 8937, giftFromEvent: false, painter: "武内崇", cardSequence: [.quick, .quick, .arts, .buster, .buster]),

            Servant(id: 37, name: "诸葛孔明〔埃尔梅罗Ⅱ世〕", classType: .caster, gender: .male, maxATK: 10598, maxHP: 14259, giftFromEvent: false, painter: "武内崇", cardSequence: [.quick, .arts, .arts, .arts, .buster]),

            Servant(id: 39, name: "佐佐木小次郎", classType: .assassin, gender: .male, maxATK: 5735, maxHP: 6220, giftFromEvent: false, painter: "MATA", cardSequence: [.quick, .quick, .quick, .arts, .buster]),

            Servant(id: 47, name: "赫拉克勒斯", classType: .berserker, gender: .male, maxATK: 10655, maxHP: 10327, giftFromEvent: false, painter: "Azusa", cardSequence: [.quick, .arts, .buster, .buster, .buster]),

            Servant(id: 163, name: "Meltryllis", classType: .alterego, gender: .female, maxATK: 11692, maxHP: 13402, giftFromEvent: false, painter: "WADA ARUKO", cardSequence: [.quick, .quick, .arts, .buster, .buster]),

            Servant(id: 166, name: "BB", classType: .moonCancer, gender: .female, maxATK: 8197, maxHP: 13643, giftFromEvent: false, painter: "WADA ARUKO", cardSequence: [.quick, .quick, .arts, .arts, .buster]),

            Servant(id: 195, name: "阿比盖尔・威廉姆斯", classType: .foreigner, gender: .female, maxATK: 12100, maxHP: 13770, giftFromEvent: false, painter: "黑星红白", cardSequence: [.quick, .arts, .arts, .arts, .buster]),

            Servant(id: 227, name: "兰陵王", classType: .saber, gender: .male, maxATK: 9112, maxHP: 12625, giftFromEvent: false, painter: "hou", cardSequence: [.quick, .arts, .arts, .buster, .buster]),

            Servant(id: 250, name: "织田信长", classType: .avenger, gender: .female, maxATK: 12641, maxHP: 11761, giftFromEvent: false, painter: "pako", cardSequence: [.quick, .arts, .buster, .buster, .buster]),

            Servant(id: 265, name: "阿尔托莉雅・潘德拉贡", classType: .ruler, gender: .female, maxATK: 9593, maxHP: 16912, giftFromEvent: false, painter: "ISHIDA AKIRA", cardSequence: [.quick, .quick, .arts, .buster, .buster]),

            Servant(id: 266, name: "谜之Alterego·Λ", classType: .lancer, gender: .female, maxATK: 9261, maxHP: 11749, giftFromEvent: false, painter: "", cardSequence: [.quick, .quick, .arts, .buster, .buster])
        ]

        return servants
    }
}
