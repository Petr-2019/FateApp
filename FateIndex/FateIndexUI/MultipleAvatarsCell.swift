//
//  MultipleAvatarsCell.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/22.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class MultipleAvatarsCell: UITableViewCell {

    static let identifier = "MultipleAvatarsCell"

    var data = [(UIImage?, String)]()

    var views = [AvatarAttachTextView]()

    func setup() {
        for (u, s) in data {
            let v = AvatarAttachTextView(avatar: u, text: s)
            views.append(v)
        }

        for v in views {
            contentView.addSubview(v)
            v.layer.cornerRadius = 8.0
            v.clipsToBounds = true
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var i: CGFloat = 0.0
        for v in views {
            v.frame = CGRect(x: 10.0 + (bounds.height - 2 * 5.0 + 10.0) * i, y: 5.0, width: bounds.height - 2 * 5.0, height: bounds.height - 2 * 5.0)

            i += 1.0
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        data.removeAll()
        views.removeAll()
    }
}
