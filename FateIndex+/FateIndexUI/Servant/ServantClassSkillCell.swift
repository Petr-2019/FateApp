//
//  ServantClassSkillCell.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/1/14.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class ServantClassSkillCell: UITableViewCell {

    class TwoLinesView: UIView {

        let topLabel = UILabel()
        let bottomLabel = UILabel()

        override init(frame: CGRect) {
            super.init(frame: frame)

            topLabel.textAlignment = .center
            bottomLabel.textAlignment = .center

            addSubview(topLabel)
            addSubview(bottomLabel)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func configure(topText: String?, bottomText: String?) {
            topLabel.text = topText
            bottomLabel.text = bottomText
        }

        override func layoutSubviews() {
            super.layoutSubviews()

            topLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height / 2)
            bottomLabel.frame = CGRect(x: 0, y: bounds.height / 2, width: bounds.width, height: bounds.height / 2)
        }
    }

    private struct Constants {
        static let avatarTopMargin: CGFloat = 5.0
        static let avatarLeadMargin: CGFloat = 20.0
        static let twoLinesMargin: CGFloat = 16.0
    }

    static let identifier = "ServantClassSkillCell"

    var skillImage: UIImage? {
        didSet {
            imageView?.image = skillImage
        }
    }

    var title: String? {
        didSet {
            textLabel?.text = title
        }
    }

    let twoLinesView = TwoLinesView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        imageView?.layer.cornerRadius = 8.0
        imageView?.clipsToBounds = true

        contentView.addSubview(twoLinesView)
    }

    func configure(topText: String?, bottomText: String?) {
        twoLinesView.configure(topText: topText, bottomText: bottomText)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let avatarHeight = bounds.height - 2 * Constants.avatarTopMargin
        let avatarWidth = avatarHeight

        // imageView?.frame = CGRect(x: Constants.avatarLeadMargin, y: Constants.avatarTopMargin, width: avatarWidth, height: avatarHeight)

        twoLinesView.frame = CGRect(x: Constants.avatarLeadMargin, y: Constants.avatarTopMargin, width: bounds.width - 2 * Constants.avatarLeadMargin, height: avatarHeight)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        skillImage = nil
        title = nil
    }
}
