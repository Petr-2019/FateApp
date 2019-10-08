//
//  NoblePhantasmDetailView.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/6.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

class NoblePhantasmDetailView: UIView {

    private let topContainer = NoblePhantasmDetailTopContainerView(frame: .zero)
    private let bottomContainer = NoblePhantasmDetailBottomContainerView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(topContainer)
        addSubview(bottomContainer)
    }

    func configure(textEn: String, textCn: String) {
        topContainer.configure(textEn: textEn, textCn: textCn)
        bottomContainer.configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let height = bounds.height / 3 * 2

        topContainer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height / 3)
        bottomContainer.frame = CGRect(x: 0, y: bounds.height / 3, width: bounds.width, height: height)
    }
}
