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
    let dispatchQueue = DispatchQueue(label: "ServantManager", qos: .userInitiated)

    func allServants(completion: @escaping ([Servant]) -> Void) -> [Servant] {
        var servants = [Servant]()
        // 1-269
        for i in 1...15 {
            let sName = String(i)

            if let path = Bundle.main.path(forResource: sName, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    let servant = try decoder.decode(Servant.self, from: data)

                    servants.append(servant)
                } catch {
                    print("The id number is \(i), error: \(error)")
                }
            }
        }

        dispatchQueue.async {
            var servants = [Servant]()
            for i in 16...280 {
                let sName = String(i)

                if let path = Bundle.main.path(forResource: sName, ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let decoder = JSONDecoder()
                        let servant = try decoder.decode(Servant.self, from: data)

                        servants.append(servant)
                    } catch {
                        print("The id number is \(i), error: \(error)")
                    }
                }
            }

            completion(servants)
        }

        return servants
    }

}
