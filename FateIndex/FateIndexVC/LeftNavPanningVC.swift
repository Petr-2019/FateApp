//
//  LeftNavPanningVC.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/5/27.
//  Copyright © 2020 管君. All rights reserved.
//

import LinkPresentation
import StoreKit
import UIKit

class LeftNavPanningVC: UIViewController {

    private enum Section: Equatable {
        case personalSpace
        case settings
    }

    private enum Row: Equatable {
        case materials
        case myCollection
        case myUserID

        case newbieIntro
        case weibo
        case appstoreReview
        case feedback
    }

    private let tableView = UITableView(frame: .zero)
    private let avatarView = UIImageView(frame: .zero)
    private let borderView = UIImageView(frame: .zero)

    private var userID: String?

    private var data = FateTableViewData<Section, Row>()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)

        view.addSubview(borderView)
        borderView.backgroundColor = .lightGray

        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        avatarView.image = UIImage(named: "male_master")
        view.addSubview(avatarView)

        reloadData()

        userID = UserDefaults.standard.string(forKey: "master_userID")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        borderView.frame = CGRect(x: (view.width - borderView.width) / 2, y: 45.0, width: 110, height: 110)
        borderView.makeRounded()
        borderView.layer.borderWidth = 0

        avatarView.frame = CGRect(x: (view.width - avatarView.width) / 2, y: 50.0, width: 100, height: 100)
        avatarView.makeRounded()

        tableView.frame = CGRect(x: 0, y: avatarView.bottom + 10.0, width: view.width, height: view.height - 50 - avatarView.height - 10.0)
    }

    private func reloadData() {
        data.removeAll()

        data.append(section: .personalSpace, with: [.materials, .myCollection, .myUserID])
        data.append(section: .settings, with: [.newbieIntro, .weibo, .appstoreReview, .feedback])
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                if traitCollection.userInterfaceStyle == .dark {
                    view.backgroundColor = .black
                }
                else {
                    view.backgroundColor = .white
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

extension LeftNavPanningVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.sectionCount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.rowCount(at: section)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch data.section(at: section) {
        case .personalSpace:
            return "个人空间"
        case .settings:
            return "通用设置"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as? SettingsCell else {
            return UITableViewCell(frame: .zero)
        }

        let text: String
        switch data.row(at: indexPath) {
        case .materials:
            text = "我的素材需求"
        case .myCollection:
            text = "我的收藏"
        case .myUserID:
            text = "我的用户ID"
        case .newbieIntro:
            text = "新手指引"
        case .weibo:
            text = "微博@Petr2020"
        case .appstoreReview:
            text = "App Store 点评"
        case .feedback:
            text = "问题反馈"
        }

        cell.textLabel?.text = text

        return cell
    }
}

extension LeftNavPanningVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch data.row(at: indexPath) {
        case .newbieIntro:
            if let url = URL(string: "https://fgo.wiki/w/%E6%96%B0%E4%BA%BA%E5%85%A5%E9%97%A8") {
                UIApplication.shared.open(url)
            }
        case .appstoreReview:
            SKStoreReviewController.requestReview()
        case .feedback:
            let email = "fateIndex@outlook.com"
            if let url = URL(string: "mailto:\(email)") {
              UIApplication.shared.open(url)
            }
        case .weibo, .materials, .myCollection:
            break
        case .myUserID:
            //1. Create the alert controller.
            let alert = UIAlertController(title: "你的用户ID", message: nil, preferredStyle: .alert)

            //2. Add the text field. You can configure it however you need.
            alert.addTextField { [weak self] textField in
                textField.placeholder = "输入用户ID"
                textField.text = self?.userID
            }

            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))

            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "分享", style: .default, handler: { [weak self] _ in
                guard let strongSelf = self else {
                    return
                }

                if let textField = alert.textFields?.first, let text = textField.text {
                    strongSelf.userID = text
                    UserDefaults.standard.set(text, forKey: "master_userID")

                    let activityVC = UIActivityViewController(activityItems: [strongSelf], applicationActivities: nil)
                    strongSelf.present(activityVC, animated: true, completion: nil)
                }
            }))

            present(alert, animated: true, completion: nil)
        }
    }
}

extension LeftNavPanningVC: UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        if let userID = userID {
            return "我的用户ID: \(userID)"
        }
        else {
            return nil
        }
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.title = "一键分享你的用户ID给朋友吧！"

        let image = Bundle.main.icon
        if let data = image?.pngData(), let url = URL(dataRepresentation: data, relativeTo: nil) {
          metadata.iconProvider = NSItemProvider(contentsOf: url)
        }

        return metadata
    }
}
