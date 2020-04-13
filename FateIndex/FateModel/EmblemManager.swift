//
//  EmblemManager.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/4/11.
//  Copyright © 2020 管君. All rights reserved.
//

import Foundation

class EmblemManager {

    static let shared = EmblemManager()

    func allEmblems() -> [Emblem] {
        var emblems = [Emblem]()

        for i in 1...60 {
            let sName = String(i)

            if let path = Bundle.main.path(forResource: "Emblem_\(sName)", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    let emblem = try decoder.decode(Emblem.self, from: data)

                    emblems.append(emblem)
                } catch {
                    print("The id number is \(i), error: \(error)")
                }
            }
        }

        return emblems
    }

}
