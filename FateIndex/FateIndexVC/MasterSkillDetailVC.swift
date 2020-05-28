//
//  MasterSkillDetailVC.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/19.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class MasterSkillDetailVC: UITableViewController {

    private enum Section {
        case basic
    }

    private enum Row: Equatable {
        case avatar
        case lvEffect(desc: String, effects: [String])
        case stableEffect(effect: String)
        case countDown
    }

    private let skill: MasterEquipment.MasterEquipmentSkill
    private var data = FateTableViewData<Section, Row>()

    init(skill: MasterEquipment.MasterEquipmentSkill) {
        self.skill = skill

        super.init(nibName: nil, bundle: nil)

        title = "技能详情"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(AvatarWithTextTableViewCell.self, forCellReuseIdentifier: AvatarWithTextTableViewCell.identifier)
        tableView.register(SelfSizeLeadTrailingTextCell.self, forCellReuseIdentifier: SelfSizeLeadTrailingTextCell.identifier)
        tableView.register(SelfSizingLabelCell.self, forCellReuseIdentifier: SelfSizingLabelCell.identifier)
        tableView.register(ActiveSkillDetailCell.self, forCellReuseIdentifier: ActiveSkillDetailCell.identifier)

        reloadData()
    }

    private func reloadData() {
        data.removeAll()

        data.append(section: .basic)
        data.append(row: .avatar, to: .basic)

        skill.lvEffects.forEach { data.append(row: .lvEffect(desc: $0.effectDesc, effects: $0.effects), to: .basic) }

        skill.stableEffects.forEach { data.append(row: .stableEffect(effect: $0), to: .basic) }

        data.append(row: .countDown, to: .basic)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.rowCount(at: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resultCell: UITableViewCell
        switch data.row(at: indexPath) {
        case .avatar:
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

            cell.avatar = UIImage(named: skill.avatar)
            cell.title = skill.skillName
            cell.selectionStyle = .none

            resultCell = cell

        case .countDown:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizeLeadTrailingTextCell.identifier, for: indexPath) as! SelfSizeLeadTrailingTextCell
            cell.nameLabel.text = "充能时间"
            cell.detailLabel.text = skill.countDown
            cell.selectionStyle = .none

            resultCell = cell

        case .stableEffect(let effect):
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizingLabelCell.identifier, for: indexPath) as! SelfSizingLabelCell
            cell.detailLabel.text = effect
            cell.detailLabel.setLineSpacing(lineSpacing: 10.0)
            cell.selectionStyle = .none

            resultCell = cell

        case .lvEffect(let desc, let effects):
            let cell = tableView.dequeueReusableCell(withIdentifier: ActiveSkillDetailCell.identifier, for: indexPath) as! ActiveSkillDetailCell
            cell.desc = desc
            cell.data = effects
            cell.selectionStyle = .none

            resultCell = cell
        }

        return resultCell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch data.row(at: indexPath) {
        case .avatar:
            return 70.0

        case .lvEffect:
            return 220.0

        default:
            return UITableView.automaticDimension
        }
    }
    
}
