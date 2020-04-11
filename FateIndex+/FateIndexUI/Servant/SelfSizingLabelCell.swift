//
//  SelfSizingLabelCell.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/4/11.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class SelfSizingLabelCell: UITableViewCell {

    static let identifier = "SelfSizingLabelCell"

    let detailLabel = UILabel()

    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let marginGuide = contentView.layoutMarginsGuide

        // configure detailLabel
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(greaterThanOrEqualTo: marginGuide.leadingAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(lessThanOrEqualTo: marginGuide.trailingAnchor).isActive = true

        detailLabel.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor).isActive = true

        detailLabel.numberOfLines = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
