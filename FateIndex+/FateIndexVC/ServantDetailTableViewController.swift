//
//  ServantDetailTableViewController.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/2.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

class ServantDetailTableViewController: UITableViewController {

    private let servant: Servant

    init(servant: Servant) {
        self.servant = servant

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ServantDetailTableViewCell.self, forCellReuseIdentifier: ServantDetailTableViewCell.identifier)
        tableView.register(ServantTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: ServantTableViewHeaderView.identifier)
        tableView.register(ServantCardSequenceTableViewCell.self, forCellReuseIdentifier: ServantCardSequenceTableViewCell.identifier)

        self.navigationItem.title = servant.name
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    // MARK:- UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell2 = tableView.dequeueReusableCell(withIdentifier: ServantDetailTableViewCell.identifier, for: indexPath) as! ServantDetailTableViewCell

        if indexPath.section == 0 {

            let cell = tableView.dequeueReusableCell(withIdentifier: ServantDetailTableViewCell.identifier, for: indexPath) as! ServantDetailTableViewCell

            if indexPath.row == 0 {
                cell.configure("画师", trailingText: servant.painter)
            }
            else if indexPath.row == 1 {
                cell.configure("声优", trailingText: "World")
            }
            else if indexPath.row == 2 {
                cell.configure("职阶", trailingText: "World")
            }
            else if indexPath.row == 3 {
                cell.configure("性别", trailingText: "World")
            }
            else if indexPath.row == 4 {
                cell.configure("身高", trailingText: "World")
            }
            else if indexPath.row == 5 {
                cell.configure("体重", trailingText: "World")
            }
            else if indexPath.row == 6 {
                cell.configure("属性", trailingText: "World")
            }
            else if indexPath.row == 7 {
                cell.configure("隐藏属性", trailingText: "World")
            }
            else if indexPath.row == 8 {
                cell.configure("筋力", trailingText: "World")
            }
            else if indexPath.row == 9 {
                cell.configure("耐久", trailingText: "World")
            }
            else if indexPath.row == 10 {
                cell.configure("敏捷", trailingText: "World")
            }
            else if indexPath.row == 11 {
                cell.configure("魔力", trailingText: "World")
            }
            else if indexPath.row == 12 {
                cell.configure("幸运", trailingText: "World")
            }
            else if indexPath.row == 13 {
                cell.configure("宝具", trailingText: "World")
            }
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ServantCardSequenceTableViewCell.identifier, for: indexPath) as! ServantCardSequenceTableViewCell

            cell.configure(text: "配卡",cardSequence: servant.cardSequence)

            return cell
        }

        return cell2
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ServantTableViewHeaderView.identifier) as! ServantTableViewHeaderView

        if section == 0 {
            headerView.title = "基础数据"
        }
        else if section == 1 {
            headerView.title = "配卡"
        }
        else if section == 2 {
            headerView.title = "职阶技能"
        }

        return headerView
    }
}
