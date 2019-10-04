//
//  Servant.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/1.
//  Copyright © 2019 管君. All rights reserved.
//

import Foundation

class Servant {

    let id: Int
    let name: String
    let classType: ServantClass
    let gender: Gender
    let maxATK: Int
    let maxHP: Int

    let giftFromEvent: Bool

    let painter: String

    let cardSequence: [CardType]

    init(id: Int, name: String, classType: ServantClass, gender: Gender, maxATK: Int, maxHP: Int, giftFromEvent: Bool, painter: String, cardSequence: [CardType]) {
        self.id = id
        self.name = name
        self.classType = classType
        self.gender = gender

        self.maxATK = maxATK
        self.maxHP = maxHP

        self.giftFromEvent = giftFromEvent

        self.painter = painter

        self.cardSequence = cardSequence
    }
}
