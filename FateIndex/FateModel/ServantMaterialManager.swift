//
//  ServantMaterialManager.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/21.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation
import UIKit

class ServantMaterialManager {

    static let shared = ServantMaterialManager()
    let dispatchQueue = DispatchQueue(label: "ServantMaterialManager", qos: .userInitiated)

    var servantMaterials = [String: ServantMaterial]()

    func loadMaterial() {
        dispatchQueue.async {
            var servantMaterials = [String: ServantMaterial]()

            for i in 1...280 {
                let sName = String(i)

                if let path = Bundle.main.path(forResource: "servant_\(sName)_material", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let decoder = JSONDecoder()
                        let servantMaterial = try decoder.decode(ServantMaterial.self, from: data)

                        servantMaterials[sName] = servantMaterial
                    } catch {
                        print("The id number is \(i), error: \(error)")
                    }
                }
            }

            DispatchQueue.main.async {
                self.servantMaterials = servantMaterials
            }
        }
    }

}
