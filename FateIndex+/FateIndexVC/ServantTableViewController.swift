//
//  ServantTableViewController.swift
//  FateIndex+
//
//  Created by 管君 on 9/26/18.
//  Copyright © 2018 管君. All rights reserved.
//

import UIKit

class ServantTableViewController: UITableViewController {
    
    private struct Constants {
        static let defaultCellHeight: CGFloat = 75.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
//                                                           target: self,
//                                                           action: #selector(closeBtnClick))
//
//        tableView.register(UINib(nibName: "ServantTableViewCell", bundle: nil), forCellReuseIdentifier: "ServantTableViewCell")
//
//        tableView.register(UINib(nibName: "NoblePhantasmNameTableViewCell", bundle: nil), forCellReuseIdentifier: "NoblePhantasmNameTableViewCell")
        
        tableView.register(ServantTableViewCell.self, forCellReuseIdentifier: ServantTableViewCell.identifier)
        tableView.register(ServantTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: ServantTableViewHeaderView.identifier)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    let name1 = ["玛修・基列莱特", "阿尔托莉雅・潘德拉贡", "阿尔托莉雅・潘德拉贡(Alter)", "阿尔托莉雅・潘德拉贡(Lily)", "尼禄・克劳狄乌斯"]
    let name2 = ["マシュ・キリエライト", "アルトリア・ペンドラゴン", "アルトリア・ペンドラゴン〔オルタ〕", "アルトリア・ペンドラゴン〔リリィ〕", "ネロ・クラウディウス"]
    let name3 = ["Mash Kyrielight", "Altria Pendragon", "Altria Pendragon (Alter)", "Altria Pendragon (Lily)", "Nero Claudius"]
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServantTableViewCell", for: indexPath) as! ServantTableViewCell

        cell.avatar = UIImage(named: "Servant00\(indexPath.row + 1)")
        cell.title = name1[indexPath.row]
        
//        cell.imageView?.image = UIImage(named: "Servant001")?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        
//        cell.noblePhantasmIcon.image = UIImage(imageLiteralResourceName: "Arts")
//        cell.phantasmTopLabel.text = "穢れを漱げ、青く美しきナイル"
//        cell.phantasmMidLabel.text = "Sneferu Iteru Nile"
//        cell.phantasmBotLabel.text = "洗刷污秽吧，青色美丽的尼罗河"


        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.defaultCellHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ServantTableViewHeaderView.identifier) as! ServantTableViewHeaderView
        
        headerView.title = "Shielder"
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37.5
    }
    
//
//    @objc func closeBtnClick(sender: UIBarButtonItem) {
//        dismiss(animated: false, completion: nil)
//    }
    
}
