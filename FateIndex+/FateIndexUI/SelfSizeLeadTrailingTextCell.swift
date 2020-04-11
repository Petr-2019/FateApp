//
//  SelfSizeLeadTrailingTextCell.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/4/11.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class SelfSizeLeadTrailingTextCell: UITableViewCell {

    static let identifier = "SelfSizeLeadTrailingTextCell"

    let nameLabel = UILabel()
    let detailLabel = UILabel()
    var equalToMargin: CGFloat = 50.0

    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let marginGuide = contentView.layoutMarginsGuide

        // configure titleLabel
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: marginGuide.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        nameLabel.numberOfLines = 1

        // configure authorLabel
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 50.0).isActive = true
        detailLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        detailLabel.numberOfLines = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
