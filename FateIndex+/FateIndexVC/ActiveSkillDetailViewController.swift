//
//  ActiveSkillViewController.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/2/9.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class ActiveSkillDetailViewController: UITableViewController {

    private let skill: Servant.Skill

    init(skill: Servant.Skill) {
        self.skill = skill

        super.init(nibName: nil, bundle: nil)

        title = skill.name
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return skill.effects.count
    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
}
