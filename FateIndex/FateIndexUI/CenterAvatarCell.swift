//
//  CenterAvatarCell.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/15.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class CenterAvatarCell: UITableViewCell {

    private struct Constants {
        static let avatarTopMargin: CGFloat = 5.0
        static let avatarLeadMargin: CGFloat = 20.0
    }

    static let identifier = "CenterAvatarCell"

    private let avatarView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(avatarView)

        avatarView.layer.cornerRadius = 8.0
        avatarView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(image: UIImage?) {
        avatarView.image = image
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let avatarHeight = bounds.height - 2 * Constants.avatarTopMargin
        let avatarWidth = avatarHeight

        avatarView.frame = CGRect(x: (bounds.width - avatarWidth) / 2, y: (bounds.height - Constants.avatarTopMargin - avatarHeight) / 2, width: avatarWidth, height: avatarHeight)
    }

}
