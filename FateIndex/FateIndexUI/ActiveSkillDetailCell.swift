//
//  ActiveSkillDetailCell.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/19.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class ActiveSkillDetailCell: UITableViewCell {

    static let identifier = "ActiveSkillDetailCell"

    private let descLabel = UILabel(frame: .zero)

    private let label1 = UILabel(frame: .zero)
    private let label2 = UILabel(frame: .zero)
    private let label3 = UILabel(frame: .zero)
    private let label4 = UILabel(frame: .zero)
    private let label5 = UILabel(frame: .zero)
    private let label6 = UILabel(frame: .zero)
    private let label7 = UILabel(frame: .zero)
    private let label8 = UILabel(frame: .zero)
    private let label9 = UILabel(frame: .zero)
    private let label10 = UILabel(frame: .zero)

    var desc: String = "" {
        didSet {
            descLabel.text = desc
        }
    }
    var data: [String] = [String]() {
        didSet {
            label1.text = data[0]
            label2.text = data[1]
            label3.text = data[2]
            label4.text = data[3]
            label5.text = data[4]
            label6.text = data[5]
            label7.text = data[6]
            label8.text = data[7]
            label9.text = data[8]
            label10.text = data[9]
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(descLabel)
        descLabel.numberOfLines = 0

        contentView.addSubview(label1)
        contentView.addSubview(label2)
        contentView.addSubview(label3)
        contentView.addSubview(label4)
        contentView.addSubview(label5)
        contentView.addSubview(label6)
        contentView.addSubview(label7)
        contentView.addSubview(label8)
        contentView.addSubview(label9)
        contentView.addSubview(label10)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let descSize = descLabel.sizeThatFits(CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude))
        let dataLabelSize1 = label1.sizeThatFits(CGSize(width: bounds.width / 3, height: CGFloat.greatestFiniteMagnitude))
        let dataLabelSize = CGSize(width: dataLabelSize1.width + 10.0, height: dataLabelSize1.height + 10.0)

        let interval = (bounds.width - 3 * dataLabelSize.width) / 4.0
        let heightInterval = (bounds.height - 4 * dataLabelSize.height - descSize.height) / 6.0

        descLabel.frame = CGRect(x: (bounds.width - descSize.width) / 2, y: heightInterval, width: descSize.width, height: descSize.height)

        label1.frame = CGRect(x: interval, y: descSize.height + 2 * heightInterval, width: dataLabelSize.width, height: dataLabelSize.height).integral
        label2.frame = CGRect(x: 2 * interval + dataLabelSize.width, y: descSize.height + 2 * heightInterval, width: dataLabelSize.width, height: dataLabelSize.height).integral
        label3.frame = CGRect(x: 3 * interval + 2 * dataLabelSize.width, y: descSize.height + 2 * heightInterval, width: dataLabelSize.width, height: dataLabelSize.height).integral

        label4.frame = CGRect(x: interval, y: descSize.height + dataLabelSize.height + 3 * heightInterval, width: dataLabelSize.width, height: dataLabelSize.height).integral
        label5.frame = CGRect(x: 2 * interval + dataLabelSize.width, y: descSize.height + dataLabelSize.height + 3 * heightInterval, width: dataLabelSize.width, height: dataLabelSize.height).integral
        label6.frame = CGRect(x: 3 * interval + 2 * dataLabelSize.width, y: descSize.height + dataLabelSize.height + 3 * heightInterval, width: dataLabelSize.width, height: dataLabelSize.height).integral

        label7.frame = CGRect(x: interval, y: descSize.height + dataLabelSize.height * 2 + 4 * heightInterval, width: dataLabelSize.width, height: dataLabelSize.height).integral
        label8.frame = CGRect(x: 2 * interval + dataLabelSize.width, y: descSize.height + dataLabelSize.height * 2 + 4 * heightInterval, width: dataLabelSize.width, height: dataLabelSize.height).integral
        label9.frame = CGRect(x: 3 * interval + 2 * dataLabelSize.width, y: descSize.height + dataLabelSize.height * 2 + 4 * heightInterval, width: dataLabelSize.width, height: dataLabelSize.height).integral

        label10.frame = CGRect(x: (bounds.width - dataLabelSize.width) / 2, y: descSize.height + dataLabelSize.height * 3 + 5 * heightInterval, width: dataLabelSize.width, height: dataLabelSize.height).integral
    }

}
