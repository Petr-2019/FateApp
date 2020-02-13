//
//  ActiveSkillViewController.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/2/9.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

enum ActiveSkillDetailRow {
    case avatarRow(avatar: String, name: String)
    case descriptionRow(text: String)
    case dataRow(data: Servant.Skill.Effects)
}

class ActiveSkillDetailViewController: UITableViewController {

    private let skill: Servant.Skill
    var dataRows = [ActiveSkillDetailRow]()

    init(skill: Servant.Skill) {
        self.skill = skill

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ActiveSkillDataCell.self, forCellReuseIdentifier: ActiveSkillDataCell.identifier)
        tableView.register(TableViewTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: TableViewTitleHeaderView.identifier)
        tableView.register(AvatarWithTextTableViewCell.self, forCellReuseIdentifier: AvatarWithTextTableViewCell.identifier)
        tableView.register(ServantDetailTableViewCell.self, forCellReuseIdentifier: ServantDetailTableViewCell.identifier)


        dataRows = [.avatarRow(avatar: skill.avatar, name: skill.name)]
        for ef in skill.effects {
            dataRows.append(.descriptionRow(text: ef.desc))
            if ef.desc == "" {
                continue
            }
            else {
                dataRows.append(.dataRow(data: ef))
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataRows[indexPath.row] {
        case .avatarRow(let avatar, let name):
            return 70.0

        case .descriptionRow(let text):
            return 70.0

        case .dataRow(let data):
            return 70.0
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return skill.effects.count
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataRows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataRows[indexPath.row] {
        case .avatarRow(let avatar, let name):
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

            cell.avatar = UIImage(named: avatar)
            cell.title = name
            return cell

        case .descriptionRow(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: ServantDetailTableViewCell.identifier, for: indexPath) as! ServantDetailTableViewCell

            cell.selectionStyle = .none
            cell.configure(text, trailingText: nil)
            return cell

        case .dataRow(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: ActiveSkillDataCell.identifier, for: indexPath) as! ActiveSkillDataCell

            cell.selectionStyle = .none
            cell.configure(skillData: data)

            return cell
        }

//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell
//
//            cell.avatar = UIImage(named: skill.avatar)
//            cell.title = skill.name
//            return cell
//        }
//        else if indexPath.row == 1 {
//
//        }
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: ActiveSkillDataCell.identifier, for: indexPath) as! ActiveSkillDataCell
//
//        cell.selectionStyle = .none
//        cell.configure(skillData: skill.effects[indexPath.section])
//
//        return cell
    }

//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewTitleHeaderView.identifier) as! TableViewTitleHeaderView
//
//        // let title = skill.effects[section].desc
//
//        headerView.title = "强化后"
//        return headerView
//    }
    
}
