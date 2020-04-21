//
//  ServantMaterial.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/21.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation

struct ServantMaterial: Codable, Equatable {
    let servantName: String
    let materials: [MaterialModel]
}

struct MaterialModel: Codable, Equatable {

    static func == (lhs: MaterialModel, rhs: MaterialModel) -> Bool {
        return lhs.materialAndCost == rhs.materialAndCost
    }

    let qp: String
    let levelName: String
    let materialAndCost: [MaterialAndCost]
}

struct MaterialAndCost: Codable, Equatable {
    let materialName: String
    let materialCost: String
}
