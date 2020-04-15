//
//  HPAndATKManager.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/15.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation

class HPAndATKManager {

    static let shared = HPAndATKManager()

    var dataDict = [String: HPAndATKModel]()

    func fetchModel(servantId: String) {
        if let path = Bundle.main.path(forResource: "Servant_\(servantId)_HP_ATK", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let model = try decoder.decode(HPAndATKModel.self, from: data)

                dataDict[servantId] = model
            } catch {
                print("The id number is \(servantId), error: \(error)")
            }
        }
    }

}
