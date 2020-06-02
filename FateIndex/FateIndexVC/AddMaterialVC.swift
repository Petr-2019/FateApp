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
        case beyondMaxlLevel
        case skill
    }

    private enum Row {
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

    private var currentBeyondMaxLevel = 0
    private var targetBeyondMaxLevel = 0
    private var skill1CurrentLevel = 1
    private var skill1TargetLevel = 1
    private var skill2CurrentLevel = 1
    private var skill2TargetLevel = 1
    private var skill3CurrentLevel = 1
    private var skill3TargetLevel = 1

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

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveTapped))

        reloadData()

        
        if let data = UserDefaults.standard.object(forKey: "\(servant.servant.no)_material_requirement") as? Data {
            let decoder = JSONDecoder()
            if let servantMaterialRequirement = try? decoder.decode(ServantMaterialRequirement.self, from: data) {
                currentBeyondMaxLevel = servantMaterialRequirement.currentBeyondMaxLevel
                targetBeyondMaxLevel = servantMaterialRequirement.targetBeyondMaxLevel
                skill1CurrentLevel = servantMaterialRequirement.skill1CurrentLevel
                skill1TargetLevel = servantMaterialRequirement.skill1TargetLevel
                skill2CurrentLevel = servantMaterialRequirement.skill2CurrentLevel
                skill2TargetLevel = servantMaterialRequirement.skill2TargetLevel
                skill3CurrentLevel = servantMaterialRequirement.skill3CurrentLevel
                skill3TargetLevel = servantMaterialRequirement.skill3TargetLevel
            }
        }
    }

    @objc private func handleSaveTapped() {
        let alertVC = UIAlertController(title: nil, message: "确认添加吗？", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))

        alertVC.addAction(UIAlertAction(title: "确认", style: .default, handler: { [weak self] _ in

            guard let strongSelf = self else {
                return
            }

            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(strongSelf.materialRequirement()) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "\(strongSelf.servant.servant.no)_material_requirement")
            }

            strongSelf.dismiss(animated: true, completion: nil)
        }))

        present(alertVC, animated: true, completion: nil)
    }

    private func materialRequirement() -> ServantMaterialRequirement {
        let materialRequirement = ServantMaterialRequirement(servantID: servant.servant.no,
                                                             currentBeyondMaxLevel: currentBeyondMaxLevel,
                                                             targetBeyondMaxLevel: targetBeyondMaxLevel,
                                                             skill1CurrentLevel: skill1CurrentLevel,
                                                             skill1TargetLevel: skill1TargetLevel,
                                                             skill2CurrentLevel: skill2CurrentLevel,
                                                             skill2TargetLevel: skill2TargetLevel,
                                                             skill3CurrentLevel: skill3CurrentLevel,
                                                             skill3TargetLevel: skill3TargetLevel)

        return materialRequirement
    }

    private func servantMaterial() -> ServantMaterial? {
        // ServantMaterial(id: "No.\(servant.servant.no)", servantName: servant.servant.name, materials: <#T##[MaterialModel]#>, maxLevelMaterials: <#T##[MaterialModel]#>)

        var maxLevelMaterials = [MaterialModel]()

        if currentBeyondMaxLevel != targetBeyondMaxLevel {
            if let material_template = ServantMaterialManager.shared.servantMaterials[servant.servant.no] {
                if targetBeyondMaxLevel == 1 {
                    if let f = material_template.maxLevelMaterials.first {
                        let maxLevelModel = MaterialModel(qp: f.qp, levelName: f.levelName, materialAndCost: f.materialAndCost)
                        maxLevelMaterials.append(maxLevelModel)
                    }
                }
                else if targetBeyondMaxLevel == 2 {
                    if currentBeyondMaxLevel == 0 {
                        if material_template.maxLevelMaterials.count >= 2 {
                            let f1 = material_template.maxLevelMaterials[0]
                            let maxLevelModel = MaterialModel(qp: f1.qp, levelName: f1.levelName, materialAndCost: f1.materialAndCost)

                            let f2 = material_template.maxLevelMaterials[1]
                            let maxLevelModel2 = MaterialModel(qp: f2.qp, levelName: f2.levelName, materialAndCost: f2.materialAndCost)

                            maxLevelMaterials.append(maxLevelModel)
                            maxLevelMaterials.append(maxLevelModel2)
                        }
                    }
                    else if currentBeyondMaxLevel == 1 {
                        if material_template.maxLevelMaterials.count >= 2 {
                            let f = material_template.maxLevelMaterials[1]
                            let maxLevelModel = MaterialModel(qp: f.qp, levelName: f.levelName, materialAndCost: f.materialAndCost)
                            maxLevelMaterials.append(maxLevelModel)
                        }
                    }
                }
                else if targetBeyondMaxLevel == 3 {
                    if currentBeyondMaxLevel == 0 {
                        if material_template.maxLevelMaterials.count >= 3 {
                            let f1 = material_template.maxLevelMaterials[0]
                            let maxLevelModel = MaterialModel(qp: f1.qp, levelName: f1.levelName, materialAndCost: f1.materialAndCost)

                            let f2 = material_template.maxLevelMaterials[1]
                            let maxLevelModel2 = MaterialModel(qp: f2.qp, levelName: f2.levelName, materialAndCost: f2.materialAndCost)

                            let f3 = material_template.maxLevelMaterials[2]
                            let maxLevelModel3 = MaterialModel(qp: f3.qp, levelName: f3.levelName, materialAndCost: f3.materialAndCost)

                            maxLevelMaterials.append(maxLevelModel)
                            maxLevelMaterials.append(maxLevelModel2)
                            maxLevelMaterials.append(maxLevelModel3)
                        }
                    }
                    else if currentBeyondMaxLevel == 1 {
                        if material_template.maxLevelMaterials.count >= 3 {
                            let f1 = material_template.maxLevelMaterials[1]
                            let maxLevelModel = MaterialModel(qp: f1.qp, levelName: f1.levelName, materialAndCost: f1.materialAndCost)

                            let f2 = material_template.maxLevelMaterials[2]
                            let maxLevelModel2 = MaterialModel(qp: f2.qp, levelName: f2.levelName, materialAndCost: f2.materialAndCost)

                            maxLevelMaterials.append(maxLevelModel)
                            maxLevelMaterials.append(maxLevelModel2)
                        }
                    }
                    else if currentBeyondMaxLevel == 2 {
                        if material_template.maxLevelMaterials.count >= 3 {
                            let f = material_template.maxLevelMaterials[2]
                            let maxLevelModel = MaterialModel(qp: f.qp, levelName: f.levelName, materialAndCost: f.materialAndCost)

                            maxLevelMaterials.append(maxLevelModel)
                        }
                    }
                }
                else if targetBeyondMaxLevel == 4 {
                    if currentBeyondMaxLevel == 0 {
                        if material_template.maxLevelMaterials.count >= 4 {
                            let f1 = material_template.maxLevelMaterials[0]
                            let maxLevelModel = MaterialModel(qp: f1.qp, levelName: f1.levelName, materialAndCost: f1.materialAndCost)

                            let f2 = material_template.maxLevelMaterials[1]
                            let maxLevelModel2 = MaterialModel(qp: f2.qp, levelName: f2.levelName, materialAndCost: f2.materialAndCost)

                            let f3 = material_template.maxLevelMaterials[2]
                            let maxLevelModel3 = MaterialModel(qp: f3.qp, levelName: f3.levelName, materialAndCost: f3.materialAndCost)

                            let f4 = material_template.maxLevelMaterials[3]
                            let maxLevelModel4 = MaterialModel(qp: f4.qp, levelName: f4.levelName, materialAndCost: f4.materialAndCost)

                            maxLevelMaterials.append(maxLevelModel)
                            maxLevelMaterials.append(maxLevelModel2)
                            maxLevelMaterials.append(maxLevelModel3)
                            maxLevelMaterials.append(maxLevelModel4)
                        }
                    }
                    else if currentBeyondMaxLevel == 1 {
                        if material_template.maxLevelMaterials.count >= 4 {
                            let f1 = material_template.maxLevelMaterials[1]
                            let maxLevelModel = MaterialModel(qp: f1.qp, levelName: f1.levelName, materialAndCost: f1.materialAndCost)

                            let f2 = material_template.maxLevelMaterials[2]
                            let maxLevelModel2 = MaterialModel(qp: f2.qp, levelName: f2.levelName, materialAndCost: f2.materialAndCost)

                            let f3 = material_template.maxLevelMaterials[3]
                            let maxLevelModel3 = MaterialModel(qp: f3.qp, levelName: f3.levelName, materialAndCost: f3.materialAndCost)

                            maxLevelMaterials.append(maxLevelModel)
                            maxLevelMaterials.append(maxLevelModel2)
                            maxLevelMaterials.append(maxLevelModel3)
                        }
                    }
                    else if currentBeyondMaxLevel == 2 {
                        if material_template.maxLevelMaterials.count >= 4 {
                            let f1 = material_template.maxLevelMaterials[2]
                            let maxLevelModel = MaterialModel(qp: f1.qp, levelName: f1.levelName, materialAndCost: f1.materialAndCost)

                            let f2 = material_template.maxLevelMaterials[3]
                            let maxLevelModel2 = MaterialModel(qp: f2.qp, levelName: f2.levelName, materialAndCost: f2.materialAndCost)

                            maxLevelMaterials.append(maxLevelModel)
                            maxLevelMaterials.append(maxLevelModel2)
                        }
                    }
                    else if currentBeyondMaxLevel == 3 {
                        if material_template.maxLevelMaterials.count >= 4 {
                            let f = material_template.maxLevelMaterials[3]
                            let maxLevelModel = MaterialModel(qp: f.qp, levelName: f.levelName, materialAndCost: f.materialAndCost)

                            maxLevelMaterials.append(maxLevelModel)
                        }
                    }
                }
            }
        }
    }

    private func skillMaterials() -> [MaterialModel] {
        
    }

    private func reloadData() {
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
        case .currentBeyondMaxlLevel:
            cell.plusAction = {
                if self.currentBeyondMaxLevel < self.targetBeyondMaxLevel {
                    self.currentBeyondMaxLevel += 1
                }
                cell.countValue = self.currentBeyondMaxLevel
            }

            cell.minusAction = {
                if self.currentBeyondMaxLevel > 0 {
                    self.currentBeyondMaxLevel -= 1
                }
                cell.countValue = self.currentBeyondMaxLevel
            }

            cell.countValue = currentBeyondMaxLevel
            cell.textLabel?.text = "当前等级"
        case .targetBeyondMaxlLevel:
            cell.plusAction = {
                if self.targetBeyondMaxLevel < 4 {
                    self.targetBeyondMaxLevel += 1
                }
                cell.countValue = self.targetBeyondMaxLevel
            }

            cell.minusAction = {
                if self.targetBeyondMaxLevel > 0 && self.targetBeyondMaxLevel > self.currentBeyondMaxLevel {
                    self.targetBeyondMaxLevel -= 1
                }
                cell.countValue = self.targetBeyondMaxLevel
            }

            cell.countValue = targetBeyondMaxLevel
            cell.textLabel?.text = "目标等级"
        case .skill1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

            let skill = servant.skill1
            cell.avatar = UIImageUtility.classSkillImage(named: skill.avatar)
            cell.title = skill.name

            return cell
        case .skill1CurrentLevel:
            cell.plusAction = {
                if self.skill1CurrentLevel < self.skill1TargetLevel {
                    self.skill1CurrentLevel += 1
                }
                cell.countValue = self.skill1CurrentLevel
            }

            cell.minusAction = {
                if self.skill1CurrentLevel > 1 {
                    self.skill1CurrentLevel -= 1
                }
                cell.countValue = self.skill1CurrentLevel
            }

            cell.countValue = skill1CurrentLevel
            cell.textLabel?.text = "当前等级"
        case .skill1TargetLevel:
            cell.plusAction = {
                if self.skill1TargetLevel < 10 {
                    self.skill1TargetLevel += 1
                }
                cell.countValue = self.skill1TargetLevel
            }

            cell.minusAction = {
                if self.skill1TargetLevel > 1 && self.skill1TargetLevel > self.skill1CurrentLevel {
                    self.skill1TargetLevel -= 1
                }
                cell.countValue = self.skill1TargetLevel
            }

            cell.countValue = skill1TargetLevel
            cell.textLabel?.text = "目标等级"
        case .skill2:
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

            let skill = servant.skill2
            cell.avatar = UIImageUtility.classSkillImage(named: skill.avatar)
            cell.title = skill.name

            return cell
        case .skill2CurrentLevel:
            cell.plusAction = {
                if self.skill2CurrentLevel < self.skill2TargetLevel {
                    self.skill2CurrentLevel += 1
                }
                cell.countValue = self.skill2CurrentLevel
            }

            cell.minusAction = {
                if self.skill2CurrentLevel > 1 {
                    self.skill2CurrentLevel -= 1
                }
                cell.countValue = self.skill2CurrentLevel
            }

            cell.countValue = skill2CurrentLevel
            cell.textLabel?.text = "当前等级"
        case .skill2TargetLevel:
            cell.plusAction = {
                if self.skill2TargetLevel < 10 {
                    self.skill2TargetLevel += 1
                }
                cell.countValue = self.skill2TargetLevel
            }

            cell.minusAction = {
                if self.skill2TargetLevel > 1 && self.skill2TargetLevel > self.skill2CurrentLevel {
                    self.skill2TargetLevel -= 1
                }
                cell.countValue = self.skill2TargetLevel
            }

            cell.countValue = skill2TargetLevel
            cell.textLabel?.text = "目标等级"
        case .skill3:
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

            let skill = servant.skill3
            cell.avatar = UIImageUtility.classSkillImage(named: skill.avatar)
            cell.title = skill.name

            return cell
        case .skill3CurrentLevel:
            cell.plusAction = {
                if self.skill3CurrentLevel < self.skill3TargetLevel {
                    self.skill3CurrentLevel += 1
                }
                cell.countValue = self.skill3CurrentLevel
            }

            cell.minusAction = {
                if self.skill3CurrentLevel > 1 {
                    self.skill3CurrentLevel -= 1
                }
                cell.countValue = self.skill3CurrentLevel
            }

            cell.countValue = skill3CurrentLevel
            cell.textLabel?.text = "当前等级"
        case .skill3TargetLevel:
            cell.plusAction = {
                if self.skill3TargetLevel < 10 {
                    self.skill3TargetLevel += 1
                }
                cell.countValue = self.skill3TargetLevel
            }

            cell.minusAction = {
                if self.skill3TargetLevel > 1 && self.skill3TargetLevel > self.skill3CurrentLevel {
                    self.skill3TargetLevel -= 1
                }
                cell.countValue = self.skill3TargetLevel
            }

            cell.countValue = skill3TargetLevel
            cell.textLabel?.text = "目标等级"
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewTitleHeaderView.identifier) as! TableViewTitleHeaderView

        let title: String = {
            switch data.section(at: section) {
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
