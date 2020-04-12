//
//  ActiveSkillViewController.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/2/9.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class ActiveSkillDetailViewController: UITableViewController {

    private enum Section {
        case basic
    }

    private enum Row: Equatable {
        case avatar(avatar: String, name: String)
        case description(text: String)
        case data(data: Servant.Skill.Effects)
    }

    private let skill: Servant.Skill
    private var data = FateTableViewData<Section, Row>()

    init(skill: Servant.Skill) {
        self.skill = skill

        super.init(nibName: nil, bundle: nil)

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ActiveSkillDataCell.self, forCellReuseIdentifier: ActiveSkillDataCell.identifier)
        tableView.register(TableViewTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: TableViewTitleHeaderView.identifier)
        tableView.register(AvatarWithTextTableViewCell.self, forCellReuseIdentifier: AvatarWithTextTableViewCell.identifier)
        tableView.register(TrailingTextTableViewCell.self, forCellReuseIdentifier: TrailingTextTableViewCell.identifier)

        reloadData()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch data.row(at: indexPath) {
        case .avatar:
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
        }
    }

}
