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
    case npRelated // NP获得率
    case classSkill // 职阶技能
    case noblePhantasm // 宝具
    case activeSkill // 主动技能

    func title() -> String {
        switch self {
        case .basicInfo:
            return "基础数据"
        case .actionCard:
            return "配卡"
        case .npRelated:
            return "NP获得率"
        case .classSkill:
            return "职阶技能"
        case .noblePhantasm:
            return "宝具"
        case .activeSkill:
            return "主动技能"
        }
    }
}

class ServantDetailTableViewController: UITableViewController {

    private let servant: Servant

    private let sections: [ServantDetailSection] = [.basicInfo, .actionCard, .npRelated, .classSkill, .noblePhantasm, .activeSkill]

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

        tableView.register(AvatarWithTextTableViewCell.self, forCellReuseIdentifier: AvatarWithTextTableViewCell.identifier)

        // self.navigationItem.title = servant.servant.name
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    // MARK:- UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 9
        }
        else if section == 1 {
            return 4
        }
        else if section == 2 {
            return 5
        }
        else if section == 3 {
            return servant.classskill.count
        }
        else if section == 4 {
            return 1
        }
        else if section == 5 {
            return 3
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

            cell.selectionStyle = .none

            if indexPath.row == 0 {
                cell.configure("编号", trailingText: servant.servant.no)
            }
            else if indexPath.row == 1 {
                cell.configure("姓名", trailingText: servant.servant.name)
            }
            else if indexPath.row == 2 {
                cell.configure("职阶", trailingText: servant.servant.clazz)
            }
            else if indexPath.row == 3 {
                cell.configure("稀有度", trailingText: "\(servant.servant.rare)")
            }
            else if indexPath.row == 4 {
                cell.configure("消耗", trailingText: "\(servant.servant.cost)")
            }
            else if indexPath.row == 5 {
                cell.configure("天地人特性", trailingText: servant.servant.tenchizin)
            }
            else if indexPath.row == 6 {
                if !servant.status.isEmpty {
                    cell.configure("满级", trailingText: servant.status[0].level)
                }
            }
            else if indexPath.row == 7 {
                if !servant.status.isEmpty {
                    cell.configure("满级 HP", trailingText: "\(servant.status[0].hp)")
                }
            }
            else if indexPath.row == 8 {
                if !servant.status.isEmpty {
                    cell.configure("满级 ATK", trailingText: "\(servant.status[0].atk)")
                }
            }

            return cell
        }
        else if indexPath.section == 1 {

            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ServantCardSequenceTableViewCell.identifier, for: indexPath) as! ServantCardSequenceTableViewCell

                cell.configure(text: "配卡", servant: servant)

                return cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ServantDetailTableViewCell.identifier, for: indexPath) as! ServantDetailTableViewCell

                cell.configure("Arts Hit", trailingText: "\(servant.card.arts.hit)")
                return cell
            }
            else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ServantDetailTableViewCell.identifier, for: indexPath) as! ServantDetailTableViewCell

                cell.configure("Quick Hit", trailingText: "\(servant.card.quick.hit)")
                return cell
            }
            else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ServantDetailTableViewCell.identifier, for: indexPath) as! ServantDetailTableViewCell

                cell.configure("Buster Hit", trailingText: "\(servant.card.buster.hit)")
                return cell
            }

            let cell = tableView.dequeueReusableCell(withIdentifier: ServantCardSequenceTableViewCell.identifier, for: indexPath) as! ServantCardSequenceTableViewCell

            return cell
        }
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ServantDetailTableViewCell.identifier, for: indexPath) as! ServantDetailTableViewCell

            cell.selectionStyle = .none

            if indexPath.row == 0 {
                cell.configure("NP获得率(攻击)", trailingText: "\(servant.hidden.na)%")
            }
            else if indexPath.row == 1 {
                cell.configure("NP获得率(受击)", trailingText: "\(servant.hidden.nd)%")
            }
            else if indexPath.row == 2 {
                cell.configure("被即死率", trailingText: "\(servant.hidden.dr)%")
            }
            else if indexPath.row == 3 {
                cell.configure("出星率", trailingText: "\(servant.hidden.staroccurrence)%")
            }
            else if indexPath.row == 4 {
                cell.configure("暴击星分配权重", trailingText: "\(servant.hidden.starcollection)")
            }

            return cell
        }
        else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

            let classSkill = servant.classskill[indexPath.row]
            
            cell.avatar = UIImageUtility.classSkillImage(named: classSkill.type)
            cell.title = classSkill.name
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

            let hogu = servant.hogu

            cell.avatar = UIImageUtility.classSkillImage(named: hogu.card)
            cell.title = hogu.name
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

            let skill: Servant.Skill

            if indexPath.row == 0 {
                skill = servant.skill1
            }
            else if indexPath.row == 1 {
                skill = servant.skill2
            }
            else {
                skill = servant.skill3
            }

            cell.avatar = UIImageUtility.classSkillImage(named: skill.effects[0].type)
            cell.title = skill.name
            cell.accessoryType = .disclosureIndicator
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
        case .npRelated:
            title = "NP获得率"
        case .classSkill:
            title = "职阶技能"
        case .noblePhantasm:
            title = "宝具"
        case .activeSkill:
            title = "主动技能"
        }

        headerView.title = title
        return headerView
    }

    // MARK:- UITableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            let classSkill = servant.classskill[indexPath.row]

            let vc = ClassSkillDetailViewController(classSkill: classSkill)
            navigationController?.pushViewController(vc, animated: true)
        }
//        guard let section = servantDetailSection(at: indexPath) else {
//            return
//        }
//
//        switch section {
//        case .basicInfo:
//            break
//        case .actionCard:
//            if indexPath.row == 1 {
//                let vc = NoblePhantasmDetailViewController()
//                navigationController?.pushViewController(vc, animated: true)
//            }
//        case .npRelated:
//            break
//        case .classSkill:
//            break
//        }
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
