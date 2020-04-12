//
//  Servant.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/1.
//  Copyright © 2019 管君. All rights reserved.
//

struct Servant: Codable {

    struct ServantBasicInfo: Codable {

        let no: String
        let name: String
        let clazz: String
        let rare: Int
        let cost: Int
        let tenchizin: String

    }

    struct Card: Codable {

        struct CardStat: Codable {
            let count: Int
            let hit: Int
        }

        let arts: CardStat
        let quick: CardStat
        let buster: CardStat
    }

    struct Status: Codable {
        let level: String
        let hp: Int
        let atk: Int
    }

    struct Hidden: Codable {

        let na: Double
        let nd: Double
        let dr: Double
        let starcollection: Int
        let staroccurrence: Double
        let tag: [String]

    }

    struct ClassSkill: Codable {

        struct Effect: Codable {
            let type: String
            let desc: String
            let magnification: String
        }

        let type: String
        let name: String
        let effect: [Effect]
    }

    struct Hogu: Codable {

        struct Effect: Codable {
            let type: String
            let turn: Int
            let count: Int
            let target: String
            let beforeafter: String
            let lvoc: String
            let desc: String
            let v1: String
            let v2: String
            let v3: String
            let v4: String
            let v5: String
        }

        let name: String
        let card: String
        let effect: [Effect]
        let type: String
        let hit: Int
    }

    struct Skill: Codable {

        struct Effects: Codable, Equatable {
            let type: String
            let turn: Int
            let count: Int
            let target: String
            let desc: String
            let v1: String
            let v2: String
            let v3: String
            let v4: String
            let v5: String
            let v6: String
            let v7: String
            let v8: String
            let v9: String
            let v10: String
        }

        let name: String
        let ct: Int
        let effects: [Effects]
        let avatar: String
    }

    let servant: ServantBasicInfo
    let card: Card
    let status: [Status]
    let hidden: Hidden
    let classskill: [ClassSkill]
    let hogu: Hogu
    let skill1: Skill
    let skill2: Skill
    let skill3: Skill
}
