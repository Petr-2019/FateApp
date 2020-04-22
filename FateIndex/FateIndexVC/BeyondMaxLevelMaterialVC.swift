//
//  BeyondMaxLevelMaterialVC.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/22.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class BeyondMaxLevelMaterialVC: UITableViewController {

    private enum Section: Equatable {
        case material(title: String)
    }

    private enum Row: Equatable {
        case material(materialAndCosts: [MaterialAndCost], qp: String)
    }

    private let material: ServantMaterial
    private var data = FateTableViewData<Section, Row>()

    init(material: ServantMaterial) {
        self.material = material

        super.init(nibName: nil, bundle: nil)

        title = "灵基再临材料"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func reloadData() {
        for ma in material.maxLevelMaterials {
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
        return 70.0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.rowCount(at: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch data.row(at: indexPath) {
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

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewTitleHeaderView.identifier) as! TableViewTitleHeaderView

        switch data.section(at: section) {
        case .material(let title):
            headerView.title = title
        }

        return headerView
    }

}
