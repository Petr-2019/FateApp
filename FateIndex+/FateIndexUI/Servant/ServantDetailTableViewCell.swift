//
//  ServantDetailTableViewCell.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/3.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

class ServantDetailTableViewCell: UITableViewCell {

    private struct Contants {
        static let textTrailingMargin: CGFloat = 20.0
    }

    static let identifier = "ServantDetailTableViewCell"

    private let trailingTextView = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        accessoryView = trailingTextView
    }
    
    func configure(_ text: String?, trailingText: String?) {
        self.textLabel?.text = text
        trailingTextView.text = trailingText
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let size = trailingTextView.intrinsicContentSize
        trailingTextView.frame = CGRect(x: bounds.width - size.width - Contants.textTrailingMargin, y: (bounds.height - size.height) / 2, width: size.width, height: size.height)
    }
}
