//
//  NoblePhantasmDetailViewController.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/6.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

class NoblePhantasmDetailViewController: UIViewController {

    private let noblePhantasmDetailView = NoblePhantasmDetailView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(noblePhantasmDetailView)
        noblePhantasmDetailView.configure(textEn: "Excalibur", textCn: "誓约胜利之剑")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let width = view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right
        let height = (view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom) * 0.7

        noblePhantasmDetailView.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: width, height: height)
    }
}
