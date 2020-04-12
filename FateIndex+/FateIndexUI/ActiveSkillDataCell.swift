//
//  ActiveSkillDataCell.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/2/11.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class ActiveSkillDataCell: UITableViewCell {

    static let identifier = "ActiveSkillDataCell"
    let activeSkillDataView = ActiveSkillDataView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(activeSkillDataView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        activeSkillDataView.frame = bounds
    }

    func configure(skillData: Servant.Skill.Effects) {
        activeSkillDataView.configure(skillData: skillData)
    }
}

class ActiveSkillDataView: UIView {

    private let labels: [UILabel] = {
        var labelButtons = [UILabel]()
        for _ in 0...9 {
            labelButtons.append(UILabel(frame: .zero))
        }
        return labelButtons
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        for label in labels {
            // labelButton.setTitle("10%", for: .normal)
            // labelButton.setTitleColor(.black, for: .normal)
            label.font = UIFont.systemFont(ofSize: 10.0)

            addSubview(label)
        }

    }

    func configure(skillData: Servant.Skill.Effects) {
        let postfix: String

        if skillData.v1.count > 3 {
            postfix = ""
        }
        else {
            postfix = "%"
        }

        labels[0].text = skillData.v1 + postfix
        labels[1].text = skillData.v2 + postfix
        labels[2].text = skillData.v3 + postfix
        labels[3].text = skillData.v4 + postfix
        labels[4].text = skillData.v5 + postfix
        labels[5].text = skillData.v6 + postfix
        labels[6].text = skillData.v7 + postfix
        labels[7].text = skillData.v8 + postfix
        labels[8].text = skillData.v9 + postfix
        labels[9].text = skillData.v10 + postfix
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

         let width = bounds.width / 11.0
         let height = bounds.height / 5.0

        var widthSum: CGFloat = 0.0
        //var heightSum: CGFloat = 0.0
        for i in 0...4 {
            labels[i].frame = CGRect(x: width + width * (CGFloat(i) * 2.0), y: height, width: width, height: height)

            widthSum += labels[i].sizeThatFits(CGSize.zero).width
            // heightSum += labels[i].sizeThatFits(CGSize.zero).height
        }

        for i in 5...9 {
            labels[i].frame = CGRect(x: width + width * (CGFloat(i - 5) * 2.0), y: height * 3.0, width: width, height: height)
        }

    }
}
