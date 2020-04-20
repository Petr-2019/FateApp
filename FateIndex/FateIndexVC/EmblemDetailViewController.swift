//
//  EmblemDetailViewController.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/4/11.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class EmblemDetailViewController: UITableViewController {

    private enum Section {
        case basic
        case skill
        case desc
    }

    private enum Row {
        case avatar
        case id
        case name
        case access
        case rare
        case artist
        case skill
        case effect
        case value
        case desc
    }

    private let emblem: Emblem

    private var data = FateTableViewData<Section, Row>()

    init(emblem: Emblem) {
        self.emblem = emblem

        super.init(nibName: nil, bundle: nil)

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(SelfSizeLeadTrailingTextCell.self, forCellReuseIdentifier: SelfSizeLeadTrailingTextCell.identifier)
        tableView.register(AvatarWithText2Cell.self, forCellReuseIdentifier: AvatarWithText2Cell.identifier)
        tableView.register(SelfSizingLabelCell.self, forCellReuseIdentifier: SelfSizingLabelCell.identifier)
        tableView.register(TableViewTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: TableViewTitleHeaderView.identifier)

        tableView.register(TrailingAvatarCell.self, forCellReuseIdentifier: TrailingAvatarCell.identifier)
        tableView.register(CenterAvatarCell.self, forCellReuseIdentifier: CenterAvatarCell.identifier)

        reloadData()
    }

    private func reloadData() {
        data.removeAll()

        data.append(section: .basic, with: [.avatar, .id, .name, .access, .rare, .artist])
        data.append(section: .skill, with: [.skill, .effect, .value])
        data.append(section: .desc, with: [.desc])
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.rowCount(at: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result: UITableViewCell
        switch data.row(at: indexPath) {
        case .avatar:
            let cell = tableView.dequeueReusableCell(withIdentifier: CenterAvatarCell.identifier, for: indexPath) as! CenterAvatarCell
            cell.selectionStyle = .none
            cell.configure(image: UIImage(named: "Emblem_\(emblem.id)"))

            result = cell

        case .id:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizeLeadTrailingTextCell.identifier, for: indexPath) as! SelfSizeLeadTrailingTextCell
            cell.nameLabel.text = "编号"
            cell.detailLabel.text = emblem.id

            result = cell

        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizeLeadTrailingTextCell.identifier, for: indexPath) as! SelfSizeLeadTrailingTextCell
            cell.nameLabel.text = "名称"
            cell.detailLabel.text = emblem.name

            result = cell

        case .access:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizeLeadTrailingTextCell.identifier, for: indexPath) as! SelfSizeLeadTrailingTextCell
            cell.nameLabel.text = "获取途径"
            cell.equalToMargin = 100.0
            cell.detailLabel.text = emblem.access

            result = cell

        case .rare:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizeLeadTrailingTextCell.identifier, for: indexPath) as! SelfSizeLeadTrailingTextCell
            cell.nameLabel.text = "稀有度"
            cell.equalToMargin = 75.0
            cell.detailLabel.text = emblem.rare

            result = cell

        case .artist:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizeLeadTrailingTextCell.identifier, for: indexPath) as! SelfSizeLeadTrailingTextCell
            cell.nameLabel.text = "画师"
            cell.detailLabel.text = emblem.artist

            result = cell

        case .skill:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrailingAvatarCell.identifier, for: indexPath) as! TrailingAvatarCell

            cell.titleLabel.text = emblem.skill
            cell.avatarView.image = UIImage(named: emblem.skill)

            result = cell

        case .effect:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizeLeadTrailingTextCell.identifier, for: indexPath) as! SelfSizeLeadTrailingTextCell
            cell.nameLabel.text = "效果"
            cell.detailLabel.text = emblem.effect

            result = cell

        case .value:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizeLeadTrailingTextCell.identifier, for: indexPath) as! SelfSizeLeadTrailingTextCell
            cell.nameLabel.text = "数值"
            cell.detailLabel.text = emblem.value

            result = cell

        case .desc:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfSizingLabelCell.identifier, for: indexPath) as! SelfSizingLabelCell
            cell.detailLabel.text = emblem.desc
            cell.detailLabel.setLineSpacing(lineSpacing: 10.0)

            result = cell
        }

        result.selectionStyle = .none
        return result
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch data.row(at: indexPath) {
        case .avatar:
            return 80.0
        case .skill:
            return 78.0
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewTitleHeaderView.identifier) as! TableViewTitleHeaderView

        if section == 0 {
            headerView.title = "基本信息"
        }
        else if section == 1 {
            headerView.title = "技能详情"
        }
        else {
            headerView.title = "解说"
        }

        return headerView
    }

}
