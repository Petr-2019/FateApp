//
//  SettingsViewController.swift
//  FateIndex+
//
//  Created by Peter Guan on 2019/7/31.
//  Copyright © 2019 管君. All rights reserved.
//

import StoreKit
import UIKit

class SettingsViewController: UIViewController {

    let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)

        self.title = "设置"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 {

        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {
                SKStoreReviewController.requestReview()
            }
            else if indexPath.row == 1 {
                let email = "peterguanjun1992@gmail.com"
                if let url = URL(string: "mailto:\(email)") {
                  UIApplication.shared.open(url)
                }
            }
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "通用设置"
        }
        else if section == 1 {
            return "其他"
        }

        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as? SettingsCell else {
            return UITableViewCell(frame: .zero)
        }

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "新手指引"
            }
            else if indexPath.row == 1 {
                cell.textLabel?.text = "捐赠"
            }
        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "App Store 点评"
            }
            else if indexPath.row == 1 {
                cell.textLabel?.text = "问题反馈"
            }
        }

        return cell
    }

}
