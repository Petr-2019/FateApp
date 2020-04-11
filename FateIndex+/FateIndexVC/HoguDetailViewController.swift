//
//  NoblePhantasmDetailViewController.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/6.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

class HoguDetailViewController: UITableViewController {

    let hogu: Servant.Hogu

    init(hogu: Servant.Hogu) {
        self.hogu = hogu
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(TrailingTextTableViewCell.self, forCellReuseIdentifier: TrailingTextTableViewCell.identifier)
        tableView.register(TableViewTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: TableViewTitleHeaderView.identifier)

        tableView.register(SelfSizeLeadTrailingTextCell.self, forCellReuseIdentifier: SelfSizeLeadTrailingTextCell.identifier)
    }

}

extension HoguDetailViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return hogu.effect.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        else {
            return 11
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result: UITableViewCell
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizeLeadTrailingTextCell.identifier, for: indexPath) as! SelfSizeLeadTrailingTextCell
                cell.nameLabel.text = "名字"
                cell.detailLabel.text = hogu.name

                result = cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("配卡", trailingText: hogu.card)

                result = cell
            }
            else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("类型", trailingText: hogu.type)

                result = cell
            }
            else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("Hit", trailingText: "\(hogu.hit)")

                result = cell
            }
            else {
                result = UITableViewCell(frame: .zero)
            }
        }
        else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizeLeadTrailingTextCell.identifier, for: indexPath) as! SelfSizeLeadTrailingTextCell
                cell.nameLabel.text = "描述"
                cell.detailLabel.text = hogu.effect[indexPath.section - 1].desc

                result = cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("回合数", trailingText: "\(hogu.effect[indexPath.section - 1].turn)")

                result = cell
            }
            else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("次数", trailingText: "\(hogu.effect[indexPath.section - 1].count)")

                result = cell
            }
            else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("对象", trailingText: hogu.effect[indexPath.section - 1].target)

                result = cell
            }
            else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("发动前后", trailingText: hogu.effect[indexPath.section - 1].beforeafter)

                result = cell
            }
            else if indexPath.row == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("LV/OC", trailingText: hogu.effect[indexPath.section - 1].lvoc.capitalized)

                result = cell
            }
            else if indexPath.row == 6 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("V1", trailingText: "\(hogu.effect[indexPath.section - 1].v1)".capitalized)

                result = cell
            }
            else if indexPath.row == 7 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("V2", trailingText: "\(hogu.effect[indexPath.section - 1].v2)".capitalized)

                result = cell
            }
            else if indexPath.row == 8 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("V3", trailingText: "\(hogu.effect[indexPath.section - 1].v3)".capitalized)

                result = cell
            }
            else if indexPath.row == 9 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("V4", trailingText: "\(hogu.effect[indexPath.section - 1].v4)".capitalized)

                result = cell
            }
            else if indexPath.row == 10 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("V5", trailingText: "\(hogu.effect[indexPath.section - 1].v5)".capitalized)

                result = cell
            }
            else {
                result = UITableViewCell(frame: .zero)
            }
        }

        result.selectionStyle = .none
        return result
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewTitleHeaderView.identifier) as! TableViewTitleHeaderView

        let title: String = {
            if section == 0 {
                return hogu.type
            }
            else {
                return hogu.effect[section - 1].type
            }
        }()

        headerView.title = title
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37.5
    }
}
