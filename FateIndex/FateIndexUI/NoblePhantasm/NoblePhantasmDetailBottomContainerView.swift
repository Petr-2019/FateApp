//
//  NoblePhantasmDetailBottomContainerView.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/6.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

class NoblePhantasmDetailBottomContainerView: UIView {

    private let topNameLabel = UILabel(frame: .zero)
    private let effectLabels = [
        UILabel(frame: .zero), UILabel(frame: .zero), UILabel(frame: .zero), UILabel(frame: .zero), UILabel(frame: .zero)
    ]

    private let bottomNameLabel = UILabel(frame: .zero)
    private let ocEffectLabels = [
        UILabel(frame: .zero), UILabel(frame: .zero), UILabel(frame: .zero), UILabel(frame: .zero), UILabel(frame: .zero)
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(topNameLabel)
        effectLabels.forEach { addSubview($0) }

        addSubview(bottomNameLabel)
        ocEffectLabels.forEach { addSubview($0) }

        topNameLabel.textAlignment = .center
        bottomNameLabel.textAlignment = .center

        effectLabels.forEach { $0.textAlignment = .center }
        ocEffectLabels.forEach { $0.textAlignment = .center }

        effectLabels.forEach { $0.layer.borderWidth = 0.5 }
        ocEffectLabels.forEach { $0.layer.borderWidth = 0.5 }

        topNameLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        bottomNameLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
    }

    func configure() {
        topNameLabel.text = "对敌方全体发动强大的攻击<宝具升级效果提升>"
        effectLabels.forEach { $0.text = "300%" }

        bottomNameLabel.text = "自身的NP增加<Over Charge时效果提升>"
        ocEffectLabels.forEach { $0.text = "20%" }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let count = CGFloat(effectLabels.isEmpty ? 1 : effectLabels.count)
        let height = bounds.height / 4
        let width = bounds.width / count

        topNameLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: height)

        for (index, element) in effectLabels.enumerated() {
            element.frame = CGRect(x: CGFloat(index) * width, y: height, width: width, height: height)
        }

        bottomNameLabel.frame = CGRect(x: 0, y: height * 2, width: bounds.width, height: height)

        for (index, element) in ocEffectLabels.enumerated() {
            element.frame = CGRect(x: CGFloat(index) * width, y: height * 3, width: width, height: height)
        }
    }

}
