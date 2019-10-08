//
//  EquipmentTableViewController.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/6.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

class EquipmentTableViewController: UIViewController {

    // private let testView = NoblePhantasmAvatarView(frame: .zero)
    // private let testView2 = NoblePhantasmDetailView(frame: .zero)

    private let testView = NoblePhantasmDetailView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(testView)
        testView.configure(textEn: "Excalibur", textCn: "誓约胜利之剑")
//        view.addSubview(testView)
//        view.addSubview(testView2)
//
//        testView.configure(image: UIImage(named: "Buster"), noblePhantasmLevel: "A", noblePhantasmTarget: "对城宝具")
//
//        testView2.configure(textEn: "Excalibur", textCn: "誓约胜利之剑")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

//        testView.frame = CGRect(x: 0, y: 100, width: 140, height: 250)
//
//        testView2.frame = CGRect(x: 140, y: 100, width: view.bounds.width - 140, height: 250)

        testView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 500)
    }
}
