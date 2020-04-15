//
//  HPAndATKModel.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/15.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation

struct HPAndATKModel: Codable {

    struct HPAndATK: Codable {
        let lv: Int
        let HP: Int
        let ATK: Int
    }

    let data: [HPAndATK]
}
