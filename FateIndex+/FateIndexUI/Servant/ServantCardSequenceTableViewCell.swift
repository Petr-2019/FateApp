//
//  ServantCardSequenceTableViewCell.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/4.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

class ServantCardSequenceTableViewCell: UITableViewCell {

    private struct Contants {
        static let textTrailingMargin: CGFloat = 20.0
    }

    static let identifier = "ServantCardSequenceTableViewCell"

    private let cardSequenceView = CardSequenceView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        accessoryView = cardSequenceView
    }

    func configure(text: String, servant: Servant) {
        textLabel?.text = text
        // cardSequenceView.configure(cardSequence: cardSequence)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let size = CGSize(width: bounds.width * 0.7, height: bounds.height)
        cardSequenceView.frame = CGRect(x: bounds.width - size.width - Contants.textTrailingMargin, y: (bounds.height - size.height) / 2, width: size.width, height: size.height)
    }
}
