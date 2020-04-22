//
//  AvatarAttachTextView.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/22.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class AvatarAttachTextView: UIImageView {

    private let label: UILabel

    var text: String? {
        didSet {
            label.text = text
        }
    }

    init(avatar: UIImage?, text: String) {
        self.label = UILabel(frame: .zero)

        super.init(frame: .zero)

        addSubview(label)
        image = avatar
        label.text = text

        label.textColor = .white
        label.shadowColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let labelSize = label.sizeThatFits(CGSize(width: bounds.width - 3.0 * 2, height: bounds.height))
        label.frame = CGRect(x: bounds.width - labelSize.width - 3.0, y: bounds.height - labelSize.height, width: labelSize.width, height: labelSize.height)
    }

}
