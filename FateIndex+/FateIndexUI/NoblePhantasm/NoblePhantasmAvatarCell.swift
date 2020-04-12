//
//  NoblePhantasmAvatarCell.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/11.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

class NoblePhantasmAvatarCell: UITableViewCell {

    private struct Constants {
        static let topMargin: CGFloat = 10.0
        static let leadingMargin: CGFloat = 10.0
        static let verticalMargin: CGFloat = 5.0
    }

    static let identifier = "NoblePhantasmAvatarCell"

    private let labelContainer = LabelContainerView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(labelContainer)
    }

    func configure(image: UIImage?, topTitle: String, midTitle: String, bottomTitle: String) {
        imageView?.image = image

        labelContainer.configure(topTitle: topTitle, midTitle: midTitle, bottomTitle: bottomTitle)
    }
}

private class LabelContainerView: UIView {

    private struct Constants {
        static let margin: CGFloat = 5.0
    }

    private let topLabel = UILabel()
    private let midLabel = UILabel()
    private let bottomLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(topLabel)
        addSubview(midLabel)
        addSubview(bottomLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let height = (bounds.height - Constants.margin * 2) / 3
        topLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: height)
        midLabel.frame = CGRect(x: 0, y: height + Constants.margin, width: bounds.width, height: height)
        bottomLabel.frame = CGRect(x: 0, y: (height + Constants.margin) * 2, width: bounds.width, height: height)
    }

    func configure(topTitle: String, midTitle: String, bottomTitle: String) {
        topLabel.text = topTitle
        midLabel.text = midTitle
        bottomLabel.text = bottomTitle
    }
}
