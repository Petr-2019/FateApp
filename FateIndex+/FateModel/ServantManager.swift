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
            Servant(id: 1, name: "玛修・基列莱特", classType: ServantClass(name: "Shielder"), gender: .female, maxATK: 8730, maxHP: 12877, giftFromEvent: true),
            Servant(id: 2, name: "阿尔托莉雅・潘德拉贡", classType: ServantClass(name: "Saber"), gender: .female, maxATK: 11221, maxHP: 15150, giftFromEvent: false),
            Servant(id: 3, name: "阿尔托莉雅・潘德拉贡(Alter)", classType: ServantClass(name: "Saber"), gender: .female, maxATK: 10248, maxHP: 11589, giftFromEvent: false),
            Servant(id: 4, name: "阿尔托莉雅・潘德拉贡(Lily)", classType: ServantClass(name: "Saber"), gender: .female, maxATK: 7726, maxHP: 10623, giftFromEvent: true),
            Servant(id: 5, name: "尼禄・克劳狄乌斯", classType: ServantClass(name: "Saber"), gender: .female, maxATK: 9449, maxHP: 11753, giftFromEvent: false),
            Servant(id: 227, name: "兰陵王", classType: ServantClass(name: "Saber"), gender: .male, maxATK: 9112, maxHP: 12625, giftFromEvent: false),
            Servant(id: 266, name: "谜之Alterego·Λ", classType: ServantClass(name: "Lancer"), gender: .female, maxATK: 9261, maxHP: 11749, giftFromEvent: false)
        ]

        return servants
    }
}
