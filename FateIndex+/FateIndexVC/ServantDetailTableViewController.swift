//
//  ServantDetailTableViewController.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/2.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

enum ServantDetailSection {
    case basicInfo // 基础数据
    case actionCard // 配卡
    case classSpec // 职阶特性
    case npRelated // NP获得率

    func title() -> String {
        switch self {
        case .basicInfo:
            return "基础数据"
        case .actionCard:
            return "配卡"
        case .classSpec:
            return "职阶特性"
        case .npRelated:
            return "NP获得率"
        }
    }
}

class ServantDetailTableViewController: UITableViewController {

    private struct Constants {
        static let sectionBasicTitle = "基础数据"
        static let sectionCardTitle = "配卡"
        static let sectionSkillTitle = "职阶技能"

    }

    private let servant: Servant

    private let sections: [ServantDetailSection] = [.basicInfo, .actionCard, .classSpec, .npRelated]

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
        tableView.register(DisclosureTableViewCell.self, forCellReuseIdentifier: DisclosureTableViewCell.identifier)

        self.navigationItem.title = servant.servant.name
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    // MARK:- UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 14
        }
        else if section == 1 {
            return 2
        }
        else if section == 2 {
            return 6
        }
        else if section == 3 {
            return 6
        }
        else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell2 = tableView.dequeueReusableCell(withIdentifier: ServantDetailTableViewCell.identifier, for: indexPath) as! ServantDetailTableViewCell

        cell2.configure("Test", trailingText: "Again")

        if indexPath.section == 0 {

            let cell = tableView.dequeueReusableCell(withIdentifier: ServantDetailTableViewCell.identifier, for: indexPath) as! ServantDetailTableViewCell

            if indexPath.row == 0 {
                // cell.configure("画师", trailingText: servant.painter)
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
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ServantCardSequenceTableViewCell.identifier, for: indexPath) as! ServantCardSequenceTableViewCell

                // cell.configure(text: "配卡",cardSequence: servant.cardSequence)

                return cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: DisclosureTableViewCell.identifier, for: indexPath) as! DisclosureTableViewCell

                cell.textLabel?.text = "宝具详情"
                return cell
            }

            let cell = tableView.dequeueReusableCell(withIdentifier: ServantCardSequenceTableViewCell.identifier, for: indexPath) as! ServantCardSequenceTableViewCell

            // cell.configure(text: "配卡",cardSequence: servant.cardSequence)

            return cell
        }
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ServantDetailTableViewCell.identifier, for: indexPath) as! ServantDetailTableViewCell

            if indexPath.row == 0 {
                cell.configure("出星率", trailingText: "10.2%")
            }
            else if indexPath.row == 1 {
                cell.configure("被即死率", trailingText: "31.5%")
            }
            else if indexPath.row == 2 {
                cell.configure("暴击星分配权重", trailingText: "98")
            }
            else if indexPath.row == 3 {
                cell.configure("特性", trailingText: "骑乘、所爱之人")
            }
            else if indexPath.row == 4 {
                cell.configure("人型", trailingText: "是")
            }
            else if indexPath.row == 5 {
                cell.configure("被EA特攻", trailingText: "是")
            }

            return cell
        }
        else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ServantDetailTableViewCell.identifier, for: indexPath) as! ServantDetailTableViewCell

            if indexPath.row == 0 {
                cell.configure("Quick", trailingText: "0.65%")
            }
            else if indexPath.row == 1 {
                cell.configure("Arts", trailingText: "0.65%")
            }
            else if indexPath.row == 2 {
                cell.configure("Buster", trailingText: "0.65%")
            }
            else if indexPath.row == 3 {
                cell.configure("Extra", trailingText: "0.65%")
            }
            else if indexPath.row == 4 {
                cell.configure("宝具", trailingText: "0.65%")
            }
            else if indexPath.row == 5 {
                cell.configure("受击", trailingText: "3%")
            }

            return cell
        }

        return cell2
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = servantDetailSection(at: section) else {
            return nil
        }

        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ServantTableViewHeaderView.identifier) as! ServantTableViewHeaderView

        let title: String

        switch section {
            case .basicInfo:
                title = "基础数据"
            case .actionCard:
                title = "配卡"
            case .classSpec:
                title = "职阶特性"
            case .npRelated:
                title = "NP获得率"
        }

        headerView.title = title
        return headerView
    }

    // MARK:- UITableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = servantDetailSection(at: indexPath) else {
            return
        }

        switch section {
        case .basicInfo:
            break
        case .actionCard:
            if indexPath.row == 1 {
                let vc = NoblePhantasmDetailViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
        case .classSpec:
            break
        case .npRelated:
            break
        }
    }

    // MARK:- Helper

    private func servantDetailSection(at indexPath: IndexPath) -> ServantDetailSection? {
        return servantDetailSection(at: indexPath.section)
    }

    private func servantDetailSection(at section: Int) -> ServantDetailSection? {
        guard section >= 0, section < sections.count else {
            return nil
        }

        return sections[section]
    }

}
