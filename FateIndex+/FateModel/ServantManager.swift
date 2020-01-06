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
        for i in 1...20 {
            let sName = String(i)

            if let path = Bundle.main.path(forResource: sName, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    let servant = try decoder.decode(Servant.self, from: data)
                    print(servant.servant.name)
                } catch {
                    print(error)
                }
            }
        }

        return []
    }

}
