//
//  MasterEquipmentDetailVC.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/19.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class MasterEquipmentDetailVC: UITableViewController {

    private enum Section {
        case basic
        case desc
        case skill
        case access
    }

    private enum Row: Equatable {
        case avatar
        case id
        case name
        case desc
        case access(text: String)
        case skill(skill: MasterEquipment.MasterEquipmentSkill)
    }

    private let masterEquipment: MasterEquipment
    private var data = FateTableViewData<Section, Row>()

    init(masterEquipment: MasterEquipment) {
        self.masterEquipment = masterEquipment

        super.init(nibName: nil, bundle: nil)

        title = "魔术礼装详情"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CenterAvatarCell.self, forCellReuseIdentifier: CenterAvatarCell.identifier)
        tableView.register(SelfSizeLeadTrailingTextCell.self, forCellReuseIdentifier: SelfSizeLeadTrailingTextCell.identifier)
        tableView.register(SelfSizingLabelCell.self, forCellReuseIdentifier: SelfSizingLabelCell.identifier)
        tableView.register(AvatarWithTextTableViewCell.self, forCellReuseIdentifier: AvatarWithTextTableViewCell.identifier)
        
        tableView.register(TableViewTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: TableViewTitleHeaderView.identifier)

        reloadData()
    }

    private func reloadData() {
        data.removeAll()

        data.append(section: .basic, with: [.avatar, .id, .name])

        data.append(section: .desc, with: [.desc])

        data.append(section: .skill)
        masterEquipment.skills.forEach { data.append(row: .skill(skill: $0), to: .skill) }

        data.append(section: .access)
        masterEquipment.access.forEach { data.append(row: .access(text: $0), to: .access) }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: CenterAvatarCell.identifier, for: indexPath) as! CenterAvatarCell
            cell.selectionStyle = .none
            cell.configure(image: UIImage(named: "Master_Equip_\(masterEquipment.id)a"))

            resultCell = cell

        case .id:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizeLeadTrailingTextCell.identifier, for: indexPath) as! SelfSizeLeadTrailingTextCell
            cell.nameLabel.text = "编号"
            cell.detailLabel.text = masterEquipment.id
            cell.selectionStyle = .none

        resultCell = cell

        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizeLeadTrailingTextCell.identifier, for: indexPath) as! SelfSizeLeadTrailingTextCell
            cell.nameLabel.text = "名称"
            cell.detailLabel.text = masterEquipment.name
            cell.selectionStyle = .none

            resultCell = cell

        case .desc:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizingLabelCell.identifier, for: indexPath) as! SelfSizingLabelCell
            cell.detailLabel.text = masterEquipment.desc
            cell.detailLabel.setLineSpacing(lineSpacing: 10.0)
            cell.selectionStyle = .none

            resultCell = cell

        case .skill(let skill):
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

            cell.avatar = UIImageUtility.classSkillImage(named: skill.avatar)
            cell.title = skill.skillName
            cell.accessoryType = .disclosureIndicator

            resultCell = cell

        case .access(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizingLabelCell.identifier, for: indexPath) as! SelfSizingLabelCell
            cell.detailLabel.text = text
            cell.detailLabel.setLineSpacing(lineSpacing: 10.0)
            cell.selectionStyle = .none

            resultCell = cell
    }

        return resultCell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch data.row(at: indexPath) {
        case .avatar:
            return 80.0
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewTitleHeaderView.identifier) as! TableViewTitleHeaderView

        switch data.section(at: section) {
        case .basic:
            headerView.title = "基本信息"
        case .desc:
            headerView.title = "解说"
        case .skill:
            headerView.title = "技能详情"
        case .access:
            headerView.title = "获取途径"
        }

        return headerView
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch data.row(at: indexPath) {
        case .skill(let skill):
            let vc = MasterSkillDetailVC(skill: skill)
            navigationController?.pushViewController(vc, animated: true)

        default:
            return
        }
    }
}
