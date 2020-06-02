//
//  ServantMaterialRequirement.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/6/2.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation

struct ServantMaterialRequirement: Codable {
    let servantID: String
    let currentBeyondMaxLevel: Int
    let targetBeyondMaxLevel: Int
    let skill1CurrentLevel: Int
    let skill1TargetLevel: Int
    let skill2CurrentLevel: Int
    let skill2TargetLevel: Int
    let skill3CurrentLevel: Int
    let skill3TargetLevel: Int
}
