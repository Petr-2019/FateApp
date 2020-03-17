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
        var servants = [Servant]()

        // 1-269
        for i in 1...143 {
            let sName = String(i)

            if let path = Bundle.main.path(forResource: sName, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    let servant = try decoder.decode(Servant.self, from: data)

                    servants.append(servant)
                } catch {
                    print(error)
                }
            }
        }

        return servants
    }

}
