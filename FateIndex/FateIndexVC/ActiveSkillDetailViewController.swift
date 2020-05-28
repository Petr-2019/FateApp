//
//  ActiveSkillViewController.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/2/9.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class ActiveSkillDetailViewController: UITableViewController {

    private enum Section: Equatable {
        case basic
        case material(title: String)
    }

    private enum Row: Equatable {
        case avatar(avatar: String, name: String)
        case description(text: String)
        case data(data: Servant.Skill.Effects)
        case material(materialAndCosts: [MaterialAndCost], qp: String)
    }

    private let skill: Servant.Skill
    private let material: ServantMaterial
    private var data = FateTableViewData<Section, Row>()

    init(skill: Servant.Skill, material: ServantMaterial) {
        self.skill = skill
        self.material = material

        super.init(nibName: nil, bundle: nil)

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

        title = "技能详情"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func reloadData() {
        data.removeAll()

        data.append(section: .basic)

        data.append(row: .avatar(avatar: skill.avatar, name: skill.name), to: .basic)

        for ef in skill.effects {
            data.append(row: .description(text: ef.desc), to: .basic)

            if ef.v1 == ef.v2, ef.v2 == ef.v3, ef.v3 == ef.v4, ef.v4 == ef.v5, ef.v5 == ef.v6, ef.v6 == ef.v7, ef.v7 == ef.v8, ef.v8 == ef.v9, ef.v9 == ef.v10 {
                if ef.v1 == "" {
                    continue
                }
                else {
                    if let _ = Int(ef.v1) {
                        data.append(row: .data(data: ef), to: .basic)
                    }
                    else {
                        data.append(row: .description(text: ef.v1), to: .basic)
                    }
                }
            }
            else {
                data.append(row: .data(data: ef), to: .basic)
            }
        }

        for ma in material.materials {
            data.append(section: .material(title: ma.levelName), with: [.material(materialAndCosts: ma.materialAndCost, qp: ma.qp)])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ActiveSkillDataCell.self, forCellReuseIdentifier: ActiveSkillDataCell.identifier)
        tableView.register(TableViewTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: TableViewTitleHeaderView.identifier)
        tableView.register(AvatarWithTextTableViewCell.self, forCellReuseIdentifier: AvatarWithTextTableViewCell.identifier)
        tableView.register(TrailingTextTableViewCell.self, forCellReuseIdentifier: TrailingTextTableViewCell.identifier)

        tableView.register(MultipleAvatarsCell.self, forCellReuseIdentifier: MultipleAvatarsCell.identifier)

        reloadData()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch data.row(at: indexPath) {
        case .avatar:
            return 70.0
        case .material:
            return 70.0
        default:
            return UITableView.automaticDimension
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.rowCount(at: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch data.row(at: indexPath) {
        case .avatar(let avatar, let name):
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

            cell.avatar = UIImage(named: avatar)
            cell.title = name
            cell.selectionStyle = .none
            return cell


        case .description(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: TrailingTextTableViewCell.identifier, for: indexPath) as! TrailingTextTableViewCell

            cell.selectionStyle = .none
            cell.configure(text, trailingText: nil)
            return cell

        case .data(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: ActiveSkillDataCell.identifier, for: indexPath) as! ActiveSkillDataCell

            cell.selectionStyle = .none
            cell.configure(skillData: data)
            return cell

        case .material(let materialAndCosts, let qp):
            let cell = tableView.dequeueReusableCell(withIdentifier: MultipleAvatarsCell.identifier, for: indexPath) as! MultipleAvatarsCell

            var d = [(UIImage?, String)]()

            for m in materialAndCosts {
                d.append((UIImage(named: m.materialName), m.materialCost))
            }

            if let num = Int(qp) {
                d.append((UIImage(named: "QP"), "\(num / 10000) w"))
            }

            cell.data = d
            cell.setup()
            cell.selectionStyle = .none

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewTitleHeaderView.identifier) as! TableViewTitleHeaderView

        switch data.section(at: section) {
        case .basic:
            headerView.title = "技能数据"
        case .material(let title):
            headerView.title = title
        }

        return headerView
    }

}
