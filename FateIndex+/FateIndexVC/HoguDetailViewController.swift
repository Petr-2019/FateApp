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
        super.init(style: .grouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(TrailingTextTableViewCell.self, forCellReuseIdentifier: TrailingTextTableViewCell.identifier)
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
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("名字", trailingText: hogu.name)

                return cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("配卡", trailingText: hogu.card)

                return cell
            }
            else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("类型", trailingText: hogu.type)

                return cell
            }
            else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("Hit", trailingText: "\(hogu.hit)")

                return cell
            }
        }
        else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("回合数", trailingText: "\(hogu.effect[indexPath.section - 1].turn)")

                return cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("次数", trailingText: "\(hogu.effect[indexPath.section - 1].count)")

                return cell
            }
            else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("对象", trailingText: hogu.effect[indexPath.section - 1].target)

                return cell
            }
            else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("发动前后", trailingText: hogu.effect[indexPath.section - 1].beforeafter)

                return cell
            }
            else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("LV/OC", trailingText: hogu.effect[indexPath.section - 1].lvoc.capitalized)

                return cell
            }
            else if indexPath.row == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("描述", trailingText: hogu.effect[indexPath.section - 1].desc)

                return cell
            }
            else if indexPath.row == 6 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("V1", trailingText: "\(hogu.effect[indexPath.section - 1].v1)".capitalized)

                return cell
            }
            else if indexPath.row == 7 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("V2", trailingText: "\(hogu.effect[indexPath.section - 1].v2)".capitalized)

                return cell
            }
            else if indexPath.row == 8 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("V3", trailingText: "\(hogu.effect[indexPath.section - 1].v3)".capitalized)

                return cell
            }
            else if indexPath.row == 9 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("V4", trailingText: "\(hogu.effect[indexPath.section - 1].v4)".capitalized)

                return cell
            }
            else if indexPath.row == 10 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell
                cell.configure("V5", trailingText: "\(hogu.effect[indexPath.section - 1].v5)".capitalized)

                return cell
            }
        }

        return UITableViewCell(frame: .zero)
    }
}
