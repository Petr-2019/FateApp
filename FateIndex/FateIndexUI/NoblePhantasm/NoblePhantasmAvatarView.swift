//
//  NoblePhantasmAvatarView.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/6.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

class NoblePhantasmAvatarView: UIView {

    private struct Constants {
        static let labelMargin: CGFloat = 15.0

        static let labelHeight: CGFloat = 15.0
    }

    private let avatarView = UIImageView(frame: .zero)

    private let levelLabel = UILabel(frame: .zero)

    private let targetNameLabel = UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(avatarView)
        addSubview(levelLabel)
        addSubview(targetNameLabel)

        backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)

        levelLabel.textAlignment = .center
        targetNameLabel.textAlignment = .center
    }

    func configure(image: UIImage?, noblePhantasmLevel: String, noblePhantasmTarget: String) {
        avatarView.image = image
        levelLabel.text = noblePhantasmLevel
        targetNameLabel.text = noblePhantasmTarget
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let avatarSize = CGSize(width: bounds.width / 2, height: bounds.width / 2)
        let labelSize = CGSize(width: bounds.width / 2, height: Constants.labelHeight)

        let height = avatarSize.height + 2 * (Constants.labelMargin + Constants.labelHeight)

        let x = (bounds.width - avatarSize.width) / 2
        let y = (bounds.height - height) / 2

        avatarView.frame = CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height)

        levelLabel.frame = CGRect(x: x, y: y + avatarSize.height + Constants.labelMargin, width: labelSize.width, height: labelSize.height)

        targetNameLabel.frame = CGRect(x: x, y: y + avatarSize.height + 2 * Constants.labelMargin + labelSize.height, width: labelSize.width, height: labelSize.height)
    }

}
