//
//  MasterEquipmentManager.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/17.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation

class MasterEquipmentManager {

    static let shared = MasterEquipmentManager()

    func allMasterEquipments() -> [MasterEquipment] {
        var masterEquipments = [MasterEquipment]()

        for i in 1...15 {
            let sName = String(i)

            if let path = Bundle.main.path(forResource: "Master_Equipment_\(sName)", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    let masterEquipment = try decoder.decode(MasterEquipment.self, from: data)

                    masterEquipments.append(masterEquipment)
                } catch {
                    print("The id number is \(i), error: \(error)")
                }
            }
        }

        return masterEquipments
    }

}
