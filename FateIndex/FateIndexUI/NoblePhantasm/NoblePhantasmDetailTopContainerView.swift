//
//  NoblePhantasmDetailTopContainerView.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/6.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

class NoblePhantasmDetailTopContainerView: UIView {

    private struct Constants {
        static let margin: CGFloat = 5.0
    }

    private let topEnNameLabel = UILabel(frame: .zero)
    private let topCnNameLabel = UILabel(frame: .zero)
    private let targetLabel = UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(topEnNameLabel)
        addSubview(topCnNameLabel)
        addSubview(targetLabel)

        backgroundColor = UIColor.red.withAlphaComponent(0.6)
        topEnNameLabel.textAlignment = .center
        topEnNameLabel.textColor = .white

        topCnNameLabel.textAlignment = .center
        topCnNameLabel.textColor = .white

        targetLabel.textAlignment = .center
        targetLabel.textColor = .white
    }

    func configure(textEn: String, textCn: String) {
        topEnNameLabel.text = textEn
        topCnNameLabel.text = textCn

        targetLabel.text = "对城宝具(A++)"
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let height = bounds.height - 4 * Constants.margin

        topEnNameLabel.frame = CGRect(x: 0, y: Constants.margin, width: bounds.width, height: height / 3)
        topCnNameLabel.frame = CGRect(x: 0, y: Constants.margin * 2 + height / 3, width: bounds.width, height: height / 3)
        targetLabel.frame = CGRect(x: 0, y: Constants.margin * 3 + height / 3 * 2, width: bounds.width, height: height / 3)
    }
}
