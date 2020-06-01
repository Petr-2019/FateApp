//
//  AddMaterialVC.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/6/1.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class AddMaterialVC: UITableViewController {

    private enum Section {
        case servantLevel
        case beyondMaxlLevel
        case skill
    }

    private enum Row {
        case currentServantLevel
        case targetServantLevel

        case currentBeyondMaxlLevel
        case targetBeyondMaxlLevel

        case skill1
        case skill1CurrentLevel
        case skill1TargetLevel

        case skill2
        case skill2CurrentLevel
        case skill2TargetLevel

        case skill3
        case skill3CurrentLevel
        case skill3TargetLevel
    }

    private var data = FateTableViewData<Section, Row>()

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

        tableView.register(SelectCountCell.self, forCellReuseIdentifier: SelectCountCell.identifier)
        tableView.register(AvatarWithTextTableViewCell.self, forCellReuseIdentifier: AvatarWithTextTableViewCell.identifier)

        tableView.register(TableViewTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: TableViewTitleHeaderView.identifier)

        reloadData()
    }

    private func reloadData() {
        data.append(section: .servantLevel, with: [.currentServantLevel, .targetServantLevel])

        data.append(section: .beyondMaxlLevel, with: [.currentBeyondMaxlLevel, .targetBeyondMaxlLevel])

        data.append(section: .skill, with: [.skill1, .skill1CurrentLevel, .skill1TargetLevel])
        data.append(rows: [.skill2, .skill2CurrentLevel, .skill2TargetLevel], to: .skill)
        data.append(rows: [.skill3, .skill3CurrentLevel, .skill3TargetLevel], to: .skill)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.rowCount(at: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectCountCell.identifier, for: indexPath) as! SelectCountCell
        switch data.row(at: indexPath) {
        case .currentServantLevel:
            cell.maxLevel = 100
            cell.textLabel?.text = "当前等级"
        case .targetServantLevel:
            cell.maxLevel = 100
            cell.textLabel?.text = "目标等级"
        case .currentBeyondMaxlLevel:
            cell.maxLevel = 4
            cell.textLabel?.text = "当前等级"
        case .targetBeyondMaxlLevel:
            cell.maxLevel = 4
            cell.textLabel?.text = "目标等级"
        case .skill1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

            let skill = servant.skill1
            cell.avatar = UIImageUtility.classSkillImage(named: skill.avatar)
            cell.title = skill.name

            return cell
        case .skill1CurrentLevel:
            cell.maxLevel = 10
            cell.textLabel?.text = "当前等级"
        case .skill1TargetLevel:
            cell.maxLevel = 10
            cell.textLabel?.text = "目标等级"
        case .skill2:
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

            let skill = servant.skill2
            cell.avatar = UIImageUtility.classSkillImage(named: skill.avatar)
            cell.title = skill.name

            return cell
        case .skill2CurrentLevel:
            cell.maxLevel = 10
            cell.textLabel?.text = "当前等级"
        case .skill2TargetLevel:
            cell.maxLevel = 10
            cell.textLabel?.text = "目标等级"
        case .skill3:
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

            let skill = servant.skill3
            cell.avatar = UIImageUtility.classSkillImage(named: skill.avatar)
            cell.title = skill.name

            return cell
        case .skill3CurrentLevel:
            cell.maxLevel = 10
            cell.textLabel?.text = "当前等级"
        case .skill3TargetLevel:
            cell.maxLevel = 10
            cell.textLabel?.text = "目标等级"
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewTitleHeaderView.identifier) as! TableViewTitleHeaderView

        let title: String = {
            switch data.section(at: section) {
            case .servantLevel:
                return "从者等级"
            case .beyondMaxlLevel:
                return "灵基再临"
            case .skill:
                return "主动技能"
            }
        }()

        headerView.title = title
        return headerView
    }
}
