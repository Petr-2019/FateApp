//
//  TrailingAvatarCell.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/4/13.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class TrailingAvatarCell: UITableViewCell {

    static let identifier = "TrailingAvatarCell"

    let titleLabel = UILabel(frame: .zero)
    let avatarView = UIImageView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        avatarView.layer.cornerRadius = 8.0
        avatarView.clipsToBounds = true

        let marginGuide = contentView.layoutMarginsGuide

        // configure titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 125.0).isActive = true
        titleLabel.numberOfLines = 1

        // configure authorLabel
        contentView.addSubview(avatarView)
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 50.0).isActive = true
        avatarView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        avatarView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        avatarView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 55.0).isActive = true
        //avatarView.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
